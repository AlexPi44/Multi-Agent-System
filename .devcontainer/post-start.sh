#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# post-start.sh  –  Runs every time the Codespace starts or resumes.
# Keep this lightweight; it runs on every wake-up.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$HOME/.local/bin:$PATH"
eval "$(pyenv init -)"

echo "▶ [post-start] LLM Engineers Handbook environment ready."
echo "   Python  : $(python --version)"
echo "   Poetry  : $(poetry --version)"
echo ""
echo "   Quick-start commands:"
echo "   ┌─ Start local infra (MongoDB + Qdrant + ZenML):"
echo "   │    poetry poe local-infrastructure-up"
echo "   ├─ Run data collection ETL:"
echo "   │    poetry poe run-digital-data-etl"
echo "   ├─ Run feature engineering pipeline:"
echo "   │    poetry poe run-feature-engineering-pipeline"
echo "   └─ Call RAG retrieval module:"
echo "        poetry poe call-rag-retrieval-module"
echo ""
