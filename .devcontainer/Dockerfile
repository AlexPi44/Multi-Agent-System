# ─────────────────────────────────────────────────────────────────────────────
# Base image: Microsoft's Debian 11 "Bullseye" dev container image.
# Matches the OS of the repo's own Dockerfile (python:3.11-slim-bullseye)
# so system library versions are identical.
# ─────────────────────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/devcontainers/base:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV POETRY_VERSION=1.8.3
ENV POETRY_NO_INTERACTION=1

# ── Google Chrome — EXACT same method as the repo's Dockerfile ───────────────
RUN apt-get update -y && \
    apt-get install -y gnupg wget curl --no-install-recommends && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | \
        gpg --dearmor -o /usr/share/keyrings/google-linux-signing-key.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update -y && \
    apt-get install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# ── System build deps — EXACT same list as the repo's Dockerfile ─────────────
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        python3-dev \
        libglib2.0-dev \
        libnss3-dev \
        # extras useful in a dev container (not in the prod image)
        git \
        jq \
        unzip \
        # pyenv build requirements
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        libncursesw5-dev \
        libffi-dev \
        liblzma-dev \
        xz-utils \
        tk-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ── pyenv — installed as the vscode user ─────────────────────────────────────
USER vscode
ENV PYENV_ROOT="/home/vscode/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

RUN curl https://pyenv.run | bash \
    && echo 'export PYENV_ROOT="$HOME/.pyenv"'                                   >> /home/vscode/.bashrc \
    && echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/vscode/.bashrc \
    && echo 'eval "$(pyenv init -)"'                                              >> /home/vscode/.bashrc \
    && echo 'export PYENV_ROOT="$HOME/.pyenv"'                                   >> /home/vscode/.profile \
    && echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/vscode/.profile \
    && echo 'eval "$(pyenv init -)"'                                              >> /home/vscode/.profile

# ── Python 3.11.8 (exact version pinned in the repo's .python-version) ───────
RUN pyenv install 3.11.8 && pyenv global 3.11.8

# ── Poetry 1.8.3 — EXACT same install method as the repo's Dockerfile ─────────
# The repo installs Poetry via pip (not the curl installer), so we do the same.
RUN pip install --no-cache-dir "poetry==$POETRY_VERSION"

# Match the repo's virtualenv setting: no separate venv, install into the
# active Python environment (mirrors `poetry config virtualenvs.create false`).
RUN poetry config virtualenvs.create false \
    && poetry config installer.max-workers 20

# ── Back to root for devcontainer feature installs ───────────────────────────
USER root
