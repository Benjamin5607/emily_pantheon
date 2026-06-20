import os
from typing import Optional

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from groq import Groq
from pydantic import BaseModel, Field

from config import DEFAULT_MODEL, FALLBACK_MODEL, TAROT_DECK, get_groq_client, list_available_models
from personas import get_dynamic_persona, normalize_lang

app = FastAPI(title="AI Pantheon API", version="0.2.2")

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
    models = [DEFAULT_MODEL, FALLBACK_MODEL]
    live = list_available_models()
    for model in live:
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


@app.get("/")
def read_root():
    return {"message": "Server is Running!"}


@app.get("/models")
def get_models():
    return {"models": list_available_models(), "default": DEFAULT_MODEL, "fallback": FALLBACK_MODEL}


@app.get("/tarot/deck")
def get_tarot_deck():
    return TAROT_DECK


@app.post("/tarot/read")
def read_tarot(request: TarotRequest):
    lang = normalize_lang(request.lang)
    system = get_dynamic_persona(lang, "tarot")
    cards_text = ", ".join(request.cards)
    user = (
        f"Topic: {request.topic}\n"
        f"Selected cards: {cards_text}\n"
        f"Question: {request.query}\n\n"
        f"Give a tarot reading as Emily. Interpret each card for this topic and weave them together."
    )
    result = _call_groq(system, user)
    return {"result": result}


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
    result = _call_groq(system, user)
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
    result = _call_groq(system, user, temperature=0.9)
    return {"result": result}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=int(os.getenv("PORT", "7860")))
