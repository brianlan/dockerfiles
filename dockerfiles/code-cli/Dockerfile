# code-cli: Development environment with AI CLI tools
# Base: Debian Bookworm Slim (x86_64)

FROM debian:bookworm-slim

# Proxy support for build
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG http_proxy=$HTTP_PROXY
ARG https_proxy=$HTTPS_PROXY

ENV DEBIAN_FRONTEND=noninteractive

# Stage 1: Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    bzip2 \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Stage 2: Install system tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    tmux \
    vim \
    tree \
    less \
    jq \
    procps \
    autojump \
    && rm -rf /var/lib/apt/lists/*

# Stage 3: Install Miniforge (Python 3.11)
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"; \
    elif [ "$ARCH" = "aarch64" ]; then \
        MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh"; \
    else \
        echo "Architecture $ARCH not supported" && exit 1; \
    fi && \
    curl -fsSL "$MINIFORGE_URL" -o /tmp/miniforge.sh && \
    bash /tmp/miniforge.sh -b -p /opt/conda && \
    rm /tmp/miniforge.sh && \
    /opt/conda/bin/conda clean -afy && \
    find /opt/conda -follow -type f -name '*.a' -delete && \
    find /opt/conda -follow -type f -name '*.js.map' -delete && \
    find /opt/conda -follow -type f -name '*.pyc' -delete && \
    find /opt/conda -follow -type d -name '__pycache__' -delete

ENV PATH=/opt/conda/bin:$PATH

# Install Python 3.11
RUN conda install -y python=3.11 && \
    conda clean -afy

# Stage 4: Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Stage 5: Install AI CLI Tools (as root for global install, then fix permissions)
RUN npm install -g @anthropic-ai/claude-code @openai/codex opencode-ai && \
    npm cache clean --force

# Stage 6: Install Oh My Zsh (as root, will copy config later)
RUN apt-get update && apt-get install -y --no-install-recommends zsh && \
    rm -rf /var/lib/apt/lists/*

# Create aiagent user
RUN useradd -m -s /bin/zsh -u 1000 aiagent && \
    mkdir -p /workspace && \
    chown aiagent:aiagent /workspace

# Install Oh My Zsh for aiagent
USER aiagent
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Configure zsh plugins
RUN sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions autojump)/' ~/.zshrc && \
    echo '[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh' >> ~/.zshrc && \
    echo 'export PATH=/opt/conda/bin:$PATH' >> ~/.zshrc

# Create config directories for AI tools
RUN mkdir -p ~/.claude ~/.codex ~/.config/opencode

# Stage 7: Final setup
USER root
RUN chown -R aiagent:aiagent /home/aiagent

USER aiagent
WORKDIR /workspace
ENV SHELL=/bin/zsh

CMD ["/bin/zsh"]
