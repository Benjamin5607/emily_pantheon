import os
from typing import Optional

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from groq import Groq
from huggingface_hub import InferenceClient
from pydantic import BaseModel, Field

from config import (
    DEFAULT_GROQ_MODEL,
    DEFAULT_HF_MODEL,
    FALLBACK_GROQ_MODEL,
    TAROT_DECK,
    get_active_provider,
    get_groq_api_key,
    get_groq_client,
    get_hf_token,
    list_available_models,
)
from personas import get_dynamic_persona, normalize_lang

app = FastAPI(title="AI Pantheon API", version="0.2.5")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


class TarotRequest(BaseModel):
    cards: list[str]
    topic: str
    query: str
    lang: str = Field(default="한국어")


class FengShuiRequest(BaseModel):
    year: int
    gender: str
    door_dir: str
    head_dir: str
    query: str
    lang: str = Field(default="한국어")
    address: Optional[str] = None
    family_info: Optional[str] = None


class SajuRequest(BaseModel):
    year: int
    month: int
    day: int
    hour: int
    minute: int
    calendar_type: str
    query: str
    lang: str = Field(default="한국어")


def _call_groq(system_prompt: str, user_prompt: str, temperature: float = 0.85) -> str:
    client = get_groq_client()
    models = [DEFAULT_GROQ_MODEL, FALLBACK_GROQ_MODEL]
    for model in list_available_models():
        if model not in models:
            models.append(model)

    last_error: Exception | None = None
    for model in models:
        try:
            response = client.chat.completions.create(
                model=model,
                messages=[
                    {"role": "system", "content": system_prompt},
                    {"role": "user", "content": user_prompt},
                ],
                temperature=temperature,
                max_tokens=2048,
            )
            content = response.choices[0].message.content
            if content:
                return content.strip()
        except Exception as exc:
            last_error = exc
            continue

    raise RuntimeError(f"All Groq models failed: {last_error}")


def _call_hf_inference(system_prompt: str, user_prompt: str, temperature: float = 0.85) -> str:
    token = get_hf_token()
    if not token:
        raise RuntimeError("HF_TOKEN is not set")

    client = InferenceClient(model=DEFAULT_HF_MODEL, token=token, timeout=90)
    response = client.chat_completion(
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_prompt},
        ],
        max_tokens=1200,
        temperature=temperature,
    )
    content = response.choices[0].message.content
    if not content:
        raise RuntimeError("Empty response from Hugging Face Inference")
    return content.strip()


def _call_llm(system_prompt: str, user_prompt: str, temperature: float = 0.85) -> str:
    provider = get_active_provider()
    if provider == "groq":
        return _call_groq(system_prompt, user_prompt, temperature)
    if provider == "huggingface":
        return _call_hf_inference(system_prompt, user_prompt, temperature)
    raise HTTPException(
        status_code=503,
        detail="No AI provider configured. Set GROQ_API_KEY or HF_TOKEN in Space secrets.",
    )


@app.get("/")
def read_root():
    return {"message": "Server is Running!"}


@app.get("/health")
def health():
    provider = get_active_provider()
    return {
        "status": "ok" if provider != "none" else "degraded",
        "provider": provider,
        "version": app.version,
    }


@app.get("/models")
def get_models():
    provider = get_active_provider()
    models = list_available_models()
    if provider == "groq":
        return {"provider": "groq", "models": models, "default": DEFAULT_GROQ_MODEL, "fallback": FALLBACK_GROQ_MODEL}
    return {"provider": provider, "models": models, "default": DEFAULT_HF_MODEL}


@app.get("/tarot/deck")
def get_tarot_deck():
    return TAROT_DECK


@app.post("/tarot/read")
def read_tarot(request: TarotRequest):
    try:
        lang = normalize_lang(request.lang)
        system = get_dynamic_persona(lang, "tarot")
        cards_text = ", ".join(request.cards)
        user = (
            f"Topic: {request.topic}\n"
            f"Selected cards: {cards_text}\n"
            f"Question: {request.query}\n\n"
            f"Give a tarot reading as Emily. Interpret each card for this topic and weave them together."
        )
        result = _call_llm(system, user)
        return {"result": result}
    except HTTPException:
        raise
    except Exception as exc:
        raise HTTPException(status_code=502, detail=str(exc)) from exc


@app.post("/fengshui/analyze")
def analyze_fengshui(request: FengShuiRequest):
    lang = normalize_lang(request.lang)
    system = get_dynamic_persona(lang, "fengshui")
    user = (
        f"Birth year: {request.year}\n"
        f"Gender: {request.gender}\n"
        f"Front door direction: {request.door_dir}\n"
        f"Sleeping head direction: {request.head_dir}\n"
        f"Question: {request.query}"
    )
    result = _call_llm(system, user)
    return {"result": result}


@app.post("/shaman/read")
def read_saju(request: SajuRequest):
    lang = normalize_lang(request.lang)
    system = get_dynamic_persona(lang, "shaman")
    user = (
        f"Birth: {request.year}-{request.month:02d}-{request.day:02d} "
        f"{request.hour:02d}:{request.minute:02d} ({request.calendar_type})\n"
        f"Question: {request.query}\n\n"
        f"Deliver a spirit oracle (공수) as Emily the young shaman. "
        f"Reference birth elements naturally but stay in Emily's voice."
    )
    result = _call_llm(system, user, temperature=0.9)
    return {"result": result}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=int(os.getenv("PORT", "7860")))
