# Emily's Pantheon (에밀리 : 만신전)

A multilingual spiritual consultation web app featuring **Emily**, a 20-year-old American woman living in Korea who reads tarot, analyzes feng shui energy, and delivers spirit oracles after receiving *sin-naerim* (spirit initiation).

**Live App:** https://benjamin5607.github.io/emily_pantheon/  
**Backend API:** https://benjamin5607-my-fortune-project.hf.space  
**API Docs:** https://benjamin5607-my-fortune-project.hf.space/docs

---

## Table of Contents

- [Overview](#overview)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Features](#features)
- [User Manual](#user-manual)
- [Supported Languages](#supported-languages)
- [AI & Cost Routing](#ai--cost-routing)
- [Project Structure](#project-structure)
- [Local Development](#local-development)
- [Deployment](#deployment)
- [Backend API Reference](#backend-api-reference)
- [Environment Variables & Secrets](#environment-variables--secrets)
- [Emily AI Persona](#emily-ai-persona)
- [Disclaimer](#disclaimer)

---

## Overview

Emily's Pantheon is a Flutter web application backed by a FastAPI server on Hugging Face Spaces. Users can explore three spiritual services through a guided, step-by-step UI:

| Service | Tab | Description |
|---------|-----|-------------|
| **Tarot** | Tarot | Three-card spread with topic, timeframe, and question |
| **Feng Shui Philosophy Cafe** | Feng Shui | Space energy analysis based on birth year and room layout |
| **Spirit Oracle (Shaman)** | Shaman | Birth-date oracle reading with spirit channeling theme |

The app supports **5 languages** (Korean, English, Chinese, Japanese, Vietnamese). All AI responses follow the selected app language.

---

## Tech Stack

### Frontend

| Layer | Technology | Purpose |
|-------|------------|---------|
| Framework | **Flutter 3.x** (Dart SDK ^3.10) | Cross-platform UI, compiled to web |
| HTTP | `http` ^1.6 | REST API calls to backend |
| Fonts | `google_fonts` ^6.3 | Cinzel (headings), Nanum Myeongjo (body) |
| Animation | `flutter_animate` ^4.5 | Shaman ritual loading effects |
| Cards | `flutter_flip_card` ^0.0.6 | Tarot card flip reveal |
| Images | `cached_network_image` ^3.4 | Wikimedia tarot card images |
| Storage | `shared_preferences` ^2.3 | 7-day tarot response cache |
| i18n | Custom `l10n.dart` | 5-language string map (no ARB/intl) |
| Hosting | **GitHub Pages** | Static web deployment via `gh-pages` branch |

### Backend

| Layer | Technology | Purpose |
|-------|------------|---------|
| Framework | **FastAPI** 0.115+ | REST API server |
| Runtime | **Python 3.12** | Server logic |
| Server | **Uvicorn** | ASGI HTTP server |
| AI (primary) | **Groq Cloud** (`groq` SDK) | Llama / GPT-OSS / Qwen models |
| AI (fallback) | **Hugging Face Inference** (`huggingface_hub`) | Qwen2.5 when `HF_TOKEN` is set |
| Validation | **Pydantic v2** | Request/response schemas |
| Hosting | **Hugging Face Spaces** (Docker) | `benjamin5607/my_fortune_project` |

### AI Models (Groq — when `GROQ_API_KEY` is configured)

| Priority | Model ID | Role |
|----------|----------|------|
| Primary | `openai/gpt-oss-120b` | Best quality for persona-heavy readings |
| Fallback | `openai/gpt-oss-20b` | Fast, cost-efficient backup |
| Backup | `qwen/qwen3.6-27b` | Strong multilingual alternative |
| Legacy | `llama-3.3-70b-versatile` | Compatibility fallback |
| Legacy | `llama-3.1-8b-instant` | Fast legacy fallback |

When only `HF_TOKEN` is set, the backend uses `Qwen/Qwen2.5-7B-Instruct` via Hugging Face Inference API.

### DevOps

| Tool | Purpose |
|------|---------|
| GitHub Actions | Frontend build + GitHub Pages deploy |
| GitHub Actions | Backend git-push to Hugging Face Space |
| Docker | HF Space container runtime |

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Flutter Web (GitHub Pages)                │
│  WelcomeScreen → MainLayoutScreen (3 tabs)                  │
│  ┌──────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  Tarot   │  │  Feng Shui   │  │   Shaman     │          │
│  └────┬─────┘  └──────┬───────┘  └──────┬───────┘          │
│       │               │                  │                  │
│  RoutingService    ApiService         ApiService             │
│  (tier1 cache)         │                  │                  │
└────────┼───────────────┼──────────────────┼─────────────────┘
         │               │                  │
         ▼               ▼                  ▼
┌─────────────────────────────────────────────────────────────┐
│           FastAPI Backend (Hugging Face Space)               │
│  /tarot/read  /fengshui/analyze  /shaman/read               │
│                                                              │
│  get_dynamic_persona(lang, service) → system prompt         │
│  _call_llm() → Groq (preferred) or HF Inference (fallback)  │
└─────────────────────────────────────────────────────────────┘
```

### Tarot Cost Routing (Frontend Only)

Tarot readings use a 3-tier strategy to reduce AI API costs:

1. **Short query (< 10 chars)** → local `assets/tier1_data.json` (free)
2. **Cliché keywords** (e.g. ex-boyfriend, lottery, job interview) → tier1 data (free)
3. **7-day cache** (SharedPreferences) → reuse previous AI answer (free)
4. **Otherwise** → paid AI via `/tarot/read`

Feng Shui and Shaman always call the AI backend directly.

---

## Features

- **Welcome entry screen** with language picker and service previews
- **5-language UI** with server-side language matching
- **Emily persona** — consistent 20-year-old American spiritual guide character
- **Tarot 3-card spread** with flip animation and Wikimedia card art
- **Feng Shui philosophy cafe** — modern, friendly space energy readings
- **Spirit oracle (shaman)** — animated ritual loading with spirit channeling theme
- **Smart tarot routing** — local fallback + cache to minimize API usage
- **Auto-deploy** — push to `main` triggers both frontend and backend deployment

---

## User Manual

### Getting Started

1. Open the app: https://benjamin5607.github.io/emily_pantheon/
2. On the **Welcome screen**, select your language from the top-right chip (Korean, English, Chinese, Japanese, Vietnamese).
3. Read the three service previews (Tarot, Feng Shui Philosophy Cafe, Spirit Oracle).
4. Tap **"Enter the Pantheon"** to enter the main app.

### Navigation

The bottom navigation bar has three tabs:

| Icon | Tab | Service |
|------|-----|---------|
| 🃏 | Tarot | Three-card tarot reading |
| 🧭 | Feng Shui | Space energy / feng shui analysis |
| ✨ | Shaman | Spirit oracle reading |

You can change language anytime from the **language icon** in the top app bar.

---

### Tarot Reading

**Step 1 — Choose a topic**

Select one of four topics:

- Love (연애)
- Money (금전)
- Work (직장)
- Health (건강)

**Step 2 — Choose a timeframe**

Pick how far ahead you want to look:

- 1 Month / 3 Months / 6 Months / 1 Year

**Step 3 — Write your question**

Type your concern in the text field.

- **Detailed questions (10+ characters)** → AI-powered reading by Emily
- **Short questions (< 10 characters)** → Basic Notes from local data (instant, free)
- **Common keywords** (ex-boyfriend, lottery, job change, etc.) → Basic Notes

Example: *"Will my ex reach out to me this year?"*

**Step 4 — Pick 3 cards**

Tap three cards from the deck. Cards are selected face-down; the reading starts automatically after the third pick.

**Step 5 — View results**

- Flip each card horizontally to reveal the Rider–Waite artwork
- Read Emily's interpretation below the cards
- Tap **Reset** to start a new reading

---

### Feng Shui Philosophy Cafe

**Step 1 — Introduction**

Tap **Next** to begin.

**Step 2 — Birth info**

Enter your **birth year** (e.g. 1990) and select **gender** (Male / Female).

**Step 3 — House info**

Provide:

- **Front door direction** (North, South, East, West, NE, NW, SE, SW)
- **Sleeping head direction** (same options)
- **Location** (city or district, e.g. "Seoul, Gangnam")

**Step 4 — Your question**

Ask about interior layout, furniture placement, moving, energy flow, etc.

Example: *"Is my sofa placement okay? Should I move?"*

Tap **Analyze** to receive Emily's feng shui advice.

**Step 5 — Results**

Read Emily's space energy analysis. Tap **Reset** to start over.

---

### Spirit Oracle (Shaman)

**Step 1 — Introduction**

Tap **Next** to begin the oracle session.

**Step 2 — Birth date & time**

- Pick your **birth date** from the calendar
- Pick your **birth time**
- Select calendar type: **Solar** or **Lunar**

**Step 3 — Your question**

Write what you want to know from the spirits.

Example: *"How is my love life this year?"*

Tap **Summoning...** to begin the ritual.

**Step 4 — Ritual & results**

- A loading animation plays while Emily connects with the spirits
- The **Spirit Oracle** message appears when ready
- Tap **Reset** to start a new session

---

## Supported Languages

| App Language | API `lang` Parameter | UI | AI Responses |
|--------------|---------------------|-----|--------------|
| Korean | `한국어` | ✅ | ✅ |
| English | `English` | ✅ | ✅ |
| Chinese | `中文` | ✅ | ✅ |
| Japanese | `日本語` | ✅ | ✅ |
| Vietnamese | `Vietnamese` | ✅ | ✅ |

Language is set in the Welcome screen or app bar and applies to both UI strings and AI response language.

---

## AI & Cost Routing

### Tarot Tier System

| Tier | Trigger | Source | Cost |
|------|---------|--------|------|
| Tier 1 | Query < 10 characters | `assets/tier1_data.json` | Free |
| Tier 1 | Cliché keyword match | `assets/tier1_data.json` | Free |
| Tier 3 | Same query within 7 days | SharedPreferences cache | Free |
| Tier 2 | All other queries | Groq / HF Inference API | Paid |

Tier 1 data covers all 22 Major Arcana cards across 4 topics (love, money, work, health) in Korean.

### Cache

Tarot AI responses are cached locally for **7 days** using the key:

```
tarot_{query}_{card1}{card2}{card3}
```

---

## Project Structure

```
emily_pantheon/
├── lib/                          # Flutter source
│   ├── main.dart                 # App entry, theme, layout shell
│   ├── l10n.dart                 # 5-language string map
│   ├── api_service.dart          # HTTP client for backend API
│   ├── routing_service.dart      # Tarot tier1/cache/AI routing
│   └── screens/
│       ├── welcome_screen.dart   # Entry / landing screen
│       ├── tarot_screen.dart     # Tarot flow (5 steps)
│       ├── fengshui_screen.dart  # Feng Shui flow (5 steps)
│       └── saju_screen.dart      # Shaman oracle flow (4 steps)
├── assets/
│   ├── images/                   # Avatars, backgrounds, card back
│   └── tier1_data.json           # Offline tarot fallback data
├── backend/                      # FastAPI backend (deployed to HF Space)
│   ├── app.py                    # API routes
│   ├── config.py                 # Groq models, tarot deck, providers
│   ├── personas.py               # Emily dynamic persona prompts
│   ├── Dockerfile                # HF Space Docker config
│   └── requirements.txt
├── web/                          # Flutter web config
├── .github/workflows/
│   ├── deploy.yml                # GitHub Pages (frontend)
│   └── deploy-hf-backend.yml     # Hugging Face Space (backend)
└── pubspec.yaml
```

---

## Local Development

### Prerequisites

- **Flutter SDK** (stable channel, Dart ^3.10)
- **Python 3.12+** (for backend)
- **Groq API key** or **Hugging Face token** (for AI responses)

### Frontend

```bash
# Clone the repository
git clone https://github.com/Benjamin5607/emily_pantheon.git
cd emily_pantheon

# Install dependencies
flutter pub get

# Run in Chrome (development)
flutter run -d chrome

# Build for web
flutter build web --release --base-href "/emily_pantheon/"
```

### Backend

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate   # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set AI provider (choose one or both)
export GROQ_API_KEY="gsk_..."        # preferred
export HF_TOKEN="hf_..."             # fallback

# Run locally
uvicorn app:app --host 0.0.0.0 --port 7860 --reload
```

API available at http://localhost:7860 — docs at http://localhost:7860/docs

To point the Flutter app at a local backend, change `baseUrl` in `lib/api_service.dart`.

---

## Deployment

### Frontend (GitHub Pages)

Automatically triggered on push to `main`:

```
.github/workflows/deploy.yml
```

1. Builds Flutter web with `--base-href "/emily_pantheon/"`
2. Publishes to `gh-pages` branch
3. Live at: https://benjamin5607.github.io/emily_pantheon/

### Backend (Hugging Face Space)

Automatically triggered on push to `main` when `backend/**` changes:

```
.github/workflows/deploy-hf-backend.yml
```

1. Clones `benjamin5607/my_fortune_project` HF Space via git
2. Rsyncs `backend/` files into the Space repo
3. Pushes — HF rebuilds the Docker container automatically

**Required GitHub Secret:**

| Secret | Description |
|--------|-------------|
| `HF_TOKEN` | Hugging Face write token (Settings → Access Tokens) |

**Optional GitHub Variable:**

| Variable | Default | Description |
|----------|---------|-------------|
| `HF_SPACE_REPO` | `benjamin5607/my_fortune_project` | Target HF Space repo ID |

**Required HF Space Secrets:**

| Secret | Description |
|--------|-------------|
| `GROQ_API_KEY` | Groq API key (preferred AI provider) |
| `HF_TOKEN` | Hugging Face token (fallback AI provider) |

Set at: https://huggingface.co/spaces/benjamin5607/my_fortune_project/settings

---

## Backend API Reference

Base URL: `https://benjamin5607-my-fortune-project.hf.space`

### Health Check

```
GET /
GET /health
GET /models
```

### Tarot

```
GET  /tarot/deck          → List of 22 Major Arcana cards
POST /tarot/read          → AI tarot reading
```

**Request body (`TarotRequest`):**

```json
{
  "cards": ["The Fool", "The Sun", "The Star"],
  "topic": "Love",
  "query": "Will I find love this year?",
  "lang": "English"
}
```

**Response:**

```json
{ "result": "Emily's tarot reading text..." }
```

### Feng Shui

```
POST /fengshui/analyze
```

**Request body (`FengShuiRequest`):**

```json
{
  "year": 1995,
  "gender": "Female",
  "door_dir": "South",
  "head_dir": "North",
  "query": "Is my sofa placement okay?",
  "lang": "한국어"
}
```

### Shaman / Spirit Oracle

```
POST /shaman/read
```

**Request body (`SajuRequest`):**

```json
{
  "year": 1995,
  "month": 6,
  "day": 15,
  "hour": 14,
  "minute": 30,
  "calendar_type": "Solar",
  "query": "How is my fortune this year?",
  "lang": "한국어"
}
```

### Language Parameter Values

| Value | Language |
|-------|----------|
| `한국어` | Korean |
| `English` | English |
| `中文` | Chinese (Simplified) |
| `日本語` | Japanese |
| `Vietnamese` | Vietnamese |

Aliases like `korean`, `ko`, `english`, `en` are also accepted and normalized server-side.

---

## Environment Variables & Secrets

### Backend (HF Space Secrets)

| Variable | Required | Description |
|----------|----------|-------------|
| `GROQ_API_KEY` | Recommended | Enables Groq models (primary provider) |
| `HF_TOKEN` | Fallback | Enables Hugging Face Inference API |
| `GROQ_MODEL` | Optional | Override default Groq model (default: `openai/gpt-oss-120b`) |
| `GROQ_FALLBACK_MODEL` | Optional | Override fallback model (default: `openai/gpt-oss-20b`) |
| `HF_MODEL` | Optional | Override HF model (default: `Qwen/Qwen2.5-7B-Instruct`) |

Provider priority: `GROQ_API_KEY` → Groq | `HF_TOKEN` only → Hugging Face Inference

### GitHub Actions Secrets

| Secret | Workflow | Description |
|--------|----------|-------------|
| `HF_TOKEN` | `deploy-hf-backend.yml` | HF write token for git push deploy |
| `GITHUB_TOKEN` | `deploy.yml` | Auto-provided for GitHub Pages |

---

## Emily AI Persona

All three services share a core character:

> **Emily (에밀리)** — a 20-year-old American woman who came to Korea as a university student and fell in love with Korean folk spirituality. She is warm, slightly Gen-Z, and speaks like a peer — never like a grandmother shaman or a stiff traditional master.

| Service | Role | Tone |
|---------|------|------|
| **Tarot** | Tarot reader at her Pantheon shop in Hongdae | Friendly, intuitive, card-by-card narrative |
| **Feng Shui** | Owner of "풍수지리 철학관" (Philosophy Cafe) | Cozy cafe conversation about space energy |
| **Shaman** | Young *sin-naerim* medium | Channels spirits as Emily, not as a 70-year-old *mudang* |

Persona prompts are generated dynamically by `get_dynamic_persona(lang, service)` in `backend/personas.py`, with strict language output rules per locale.

---

## Disclaimer

This app is for **entertainment purposes only**. AI-generated readings (tarot, feng shui, spirit oracle) are not professional advice. For important life decisions regarding health, finance, or legal matters, please consult qualified professionals.

---

## License

This project is for personal and educational use. Tarot card images are sourced from [Wikimedia Commons](https://commons.wikimedia.org/) (Rider–Waite deck, public domain).

---

## Links

- **Live App:** https://benjamin5607.github.io/emily_pantheon/
- **Backend API:** https://benjamin5607-my-fortune-project.hf.space
- **API Swagger UI:** https://benjamin5607-my-fortune-project.hf.space/docs
- **HF Space:** https://huggingface.co/spaces/benjamin5607/my_fortune_project
- **GitHub Repo:** https://github.com/Benjamin5607/emily_pantheon
