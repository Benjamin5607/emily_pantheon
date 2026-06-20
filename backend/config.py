import os
from groq import Groq
from huggingface_hub import InferenceClient

# Groq production models (updated June 2026)
GROQ_MODELS = [
    "openai/gpt-oss-120b",
    "openai/gpt-oss-20b",
    "qwen/qwen3.6-27b",
    "llama-3.3-70b-versatile",
    "llama-3.1-8b-instant",
]

DEFAULT_GROQ_MODEL = os.getenv("GROQ_MODEL", "openai/gpt-oss-120b")
FALLBACK_GROQ_MODEL = os.getenv("GROQ_FALLBACK_MODEL", "openai/gpt-oss-20b")
DEFAULT_HF_MODEL = os.getenv("HF_MODEL", "Qwen/Qwen2.5-7B-Instruct")

TAROT_DECK = [
    {"name": "The Fool", "id": 0, "desc": "새로운 시작, 모험, 순수함", "image": "https://upload.wikimedia.org/wikipedia/commons/9/90/RWS_Tarot_00_Fool.jpg"},
    {"name": "The Magician", "id": 1, "desc": "창조력, 기술, 의지", "image": "https://upload.wikimedia.org/wikipedia/commons/d/de/RWS_Tarot_01_Magician.jpg"},
    {"name": "The High Priestess", "id": 2, "desc": "지혜, 직관, 신비", "image": "https://upload.wikimedia.org/wikipedia/commons/8/88/RWS_Tarot_02_High_Priestess.jpg"},
    {"name": "The Empress", "id": 3, "desc": "풍요, 모성, 자연", "image": "https://upload.wikimedia.org/wikipedia/commons/d/d2/RWS_Tarot_03_Empress.jpg"},
    {"name": "The Emperor", "id": 4, "desc": "권위, 구조, 아버지", "image": "https://upload.wikimedia.org/wikipedia/commons/c/c3/RWS_Tarot_04_Emperor.jpg"},
    {"name": "The Hierophant", "id": 5, "desc": "전통, 신념, 교육", "image": "https://upload.wikimedia.org/wikipedia/commons/8/8d/RWS_Tarot_05_Hierophant.jpg"},
    {"name": "The Lovers", "id": 6, "desc": "사랑, 조화, 선택", "image": "https://upload.wikimedia.org/wikipedia/commons/3/3a/TheLovers.jpg"},
    {"name": "The Chariot", "id": 7, "desc": "승리, 의지력, 전진", "image": "https://upload.wikimedia.org/wikipedia/commons/9/9b/RWS_Tarot_07_Chariot.jpg"},
    {"name": "Strength", "id": 8, "desc": "인내, 용기, 내면의 힘", "image": "https://upload.wikimedia.org/wikipedia/commons/f/f5/RWS_Tarot_08_Strength.jpg"},
    {"name": "The Hermit", "id": 9, "desc": "성찰, 고독, 탐구", "image": "https://upload.wikimedia.org/wikipedia/commons/4/4d/RWS_Tarot_09_Hermit.jpg"},
    {"name": "Wheel of Fortune", "id": 10, "desc": "운명, 변화, 주기", "image": "https://upload.wikimedia.org/wikipedia/commons/3/3c/RWS_Tarot_10_Wheel_of_Fortune.jpg"},
    {"name": "Justice", "id": 11, "desc": "정의, 진실, 인과응보", "image": "https://upload.wikimedia.org/wikipedia/commons/e/e0/RWS_Tarot_11_Justice.jpg"},
    {"name": "The Hanged Man", "id": 12, "desc": "희생, 새로운 관점, 정지", "image": "https://upload.wikimedia.org/wikipedia/commons/2/2b/RWS_Tarot_12_Hanged_Man.jpg"},
    {"name": "Death", "id": 13, "desc": "변화, 종료, 재탄생", "image": "https://upload.wikimedia.org/wikipedia/commons/d/d7/RWS_Tarot_13_Death.jpg"},
    {"name": "Temperance", "id": 14, "desc": "균형, 조화, 인내", "image": "https://upload.wikimedia.org/wikipedia/commons/f/f8/RWS_Tarot_14_Temperance.jpg"},
    {"name": "The Devil", "id": 15, "desc": "유혹, 속박, 집착", "image": "https://upload.wikimedia.org/wikipedia/commons/5/55/RWS_Tarot_15_Devil.jpg"},
    {"name": "The Tower", "id": 16, "desc": "파괴, 급변, 깨달음", "image": "https://upload.wikimedia.org/wikipedia/commons/5/53/RWS_Tarot_16_Tower.jpg"},
    {"name": "The Star", "id": 17, "desc": "희망, 영감, 치유", "image": "https://upload.wikimedia.org/wikipedia/commons/d/db/RWS_Tarot_17_Star.jpg"},
    {"name": "The Moon", "id": 18, "desc": "환상, 불안, 무의식", "image": "https://upload.wikimedia.org/wikipedia/commons/7/7f/RWS_Tarot_18_Moon.jpg"},
    {"name": "The Sun", "id": 19, "desc": "성공, 활력, 기쁨", "image": "https://upload.wikimedia.org/wikipedia/commons/1/17/RWS_Tarot_19_Sun.jpg"},
    {"name": "Judgement", "id": 20, "desc": "심판, 부활, 각성", "image": "https://upload.wikimedia.org/wikipedia/commons/d/dd/RWS_Tarot_20_Judgement.jpg"},
    {"name": "The World", "id": 21, "desc": "완성, 성취, 통합", "image": "https://upload.wikimedia.org/wikipedia/commons/f/ff/RWS_Tarot_21_World.jpg"},
]


def get_groq_api_key() -> str | None:
    for name in ("GROQ_API_KEY", "GROQ_KEY"):
        value = os.getenv(name)
        if value:
            return value
    return None


def get_hf_token() -> str | None:
    for name in ("HF_TOKEN", "HUGGINGFACEHUB_API_TOKEN"):
        value = os.getenv(name)
        if value:
            return value
    return None


def get_active_provider() -> str:
    if get_groq_api_key():
        return "groq"
    if get_hf_token():
        return "huggingface"
    return "none"


def get_groq_client() -> Groq:
    api_key = get_groq_api_key()
    if not api_key:
        raise RuntimeError("GROQ_API_KEY is not set")
    return Groq(api_key=api_key)


def list_available_models() -> list[str]:
    if get_groq_api_key():
        try:
            client = get_groq_client()
            live = [
                m.id
                for m in client.models.list().data
                if "whisper" not in m.id
                and "orpheus" not in m.id
                and "prompt-guard" not in m.id
                and "safeguard" not in m.id
            ]
            ordered = [m for m in GROQ_MODELS if m in live]
            extras = [m for m in live if m not in ordered]
            return ordered + extras
        except Exception:
            return GROQ_MODELS.copy()
    return [DEFAULT_HF_MODEL]
