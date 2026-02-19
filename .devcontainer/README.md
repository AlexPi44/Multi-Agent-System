# .devcontainer — LLM Engineers Handbook + Multi-Agent Extensions

This folder sets up a reproducible GitHub Codespaces environment that exactly
matches the tooling described in *LLM Engineer's Handbook* (Python 3.11.8,
Poetry 1.8.3, Docker-in-Docker, Google Chrome, AWS CLI).

---

## What's inside

| File | Purpose |
|---|---|
| `devcontainer.json` | Main Codespaces config — features, ports, VS Code extensions |
| `Dockerfile` | Base image with pyenv, Python 3.11.8, Poetry 1.8.3, Chrome |
| `on-create.sh` | Runs **once** on first build — installs all Poetry deps |
| `post-create.sh` | Runs after on-create — creates `.env` from template |
| `post-start.sh` | Runs on **every** start/resume — prints a quick-start cheat sheet |

---

## Getting started

1. **Open in Codespaces** — Click the green *Code* button → *Codespaces* → *New codespace*.
2. Wait for the build (first time ~5–10 min; subsequent starts are instant).
3. Fill in your `.env` file with API keys:
   ```
   OPENAI_API_KEY=sk-...
   HUGGINGFACE_ACCESS_TOKEN=hf_...
   COMET_API_KEY=...
   ```
4. Start local infrastructure:
   ```bash
   poetry poe local-infrastructure-up
   ```
5. Open the ZenML dashboard at the **Ports** tab → port `8237`.

---

## Services & ports

| Service | Port | URL |
|---|---|---|
| ZenML Dashboard | 8237 | http://localhost:8237 (user: `default`, pass: _empty_) |
| Qdrant REST + Dashboard | 6333 | http://localhost:6333/dashboard |
| MongoDB | 27017 | `mongodb://llm_engineering:llm_engineering@localhost:27017` |
| Inference API | 8000 | http://localhost:8000 |

---

## Adding multi-agent / CrewAI support

When you're ready to extend the project with multi-agent frameworks, add the
following to the `[tool.poetry.dependencies]` section of `pyproject.toml`
and run `poetry install`:

```toml
# Multi-agent frameworks
crewai = ">=0.80.0,<1.0.0"          # CrewAI orchestration
crewai-tools = ">=0.14.0"            # Built-in CrewAI tools
langchain = ">=0.3.0,<0.4.0"        # LangChain (used by many agent frameworks)
langchain-openai = ">=0.2.0"
langchain-community = ">=0.3.0"
langgraph = ">=0.2.0"               # Graph-based agent orchestration (alternative)
openai-agents = ">=0.0.7"           # OpenAI Agents SDK
```

Or install them ad-hoc during development:
```bash
poetry add crewai crewai-tools langgraph
```

---

## Enabling AWS (Chapters 10 & 11)

Re-install with the AWS extras:
```bash
poetry install --with aws
```

Then fill in your `.env`:
```
AWS_REGION=eu-central-1
AWS_ACCESS_KEY=...
AWS_SECRET_KEY=...
AWS_ARN_ROLE=...
```

---

## Exact versions pinned

| Tool | Version |
|---|---|
| Python | 3.11.8 |
| Poetry | 1.8.3 |
| Docker | ≥ 27.1.1 (via feature) |
| AWS CLI | 2.15.42 (via feature) |
| Google Chrome | Stable (latest) |
