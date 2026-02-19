#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# on-create.sh  –  Runs ONCE when the Codespace container is first built.
# Heavy, slow tasks go here (they're cached by Codespaces prebuild).
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

echo "▶ [on-create] Installing Python dependencies via Poetry..."

# Ensure pyenv shims are on PATH in non-interactive shells
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$HOME/.local/bin:$PATH"
eval "$(pyenv init -)"

# Pin the local Python version (matches the repo's .python-version file)
pyenv local 3.11.8

# Install all dependencies (excluding AWS-specific extras for now).
# Note: virtualenvs.create is false (set in Dockerfile), so packages install
# directly into the active Python — matching how the prod Docker image works.
# No `--no-root` here unlike the prod image, because we want the editable install.
poetry install --without aws

# Install Poe the Poet as a Poetry plugin (same command as the repo's README)
poetry self add 'poethepoet[poetry_plugin]'

# Install pre-commit hooks
pre-commit install

echo "✅ [on-create] Python environment ready."
echo "   Note: no 'poetry shell' needed — packages are in the global Python env."
