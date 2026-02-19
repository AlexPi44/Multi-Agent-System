#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# post-create.sh  –  Runs after on-create.sh on every new Codespace creation.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

echo "▶ [post-create] Setting up .env file..."

# Create .env from the example template if it doesn't exist yet
if [ ! -f .env ]; then
  cp .env.example .env
  echo ""
  echo "  ⚠️  A .env file has been created from .env.example."
  echo "  Please fill in your credentials:"
  echo "    - OPENAI_API_KEY"
  echo "    - HUGGINGFACE_ACCESS_TOKEN"
  echo "    - COMET_API_KEY"
  echo "  (AWS credentials are optional until you reach Chapter 10/11)"
  echo ""
fi

echo "✅ [post-create] Done."
