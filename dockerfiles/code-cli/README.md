# Code-CLI Docker Image

A minimal development environment with AI-powered CLI coding tools.

## Included Tools

### AI CLI Tools
- **[Claude Code](https://github.com/anthropic-ai/claude-code)** - Anthropic's agentic coding assistant
- **[OpenAI Codex](https://github.com/openai/codex)** - OpenAI's CLI coding tool
- **[Opencode](https://opencode.ai)** - Open-source AI coding assistant

### Development Tools
- **Miniforge** (Python 3.11) - Conda package manager
- **Node.js 20** - JavaScript runtime
- **Zsh** with Oh My Zsh - Shell environment
- **Tmux** - Terminal multiplexer
- **Git, Vim, Tree, Curl, Wget** - Essential utilities
- **Zsh Plugins**: git, zsh-autosuggestions, autojump

## Build

### Basic Build
```bash
docker build -f dockerfiles/code-cli/Dockerfile -t code-cli:latest .
```

### Build with Proxy
```bash
docker build \
  --build-arg HTTP_PROXY=http://proxy:port \
  --build-arg HTTPS_PROXY=http://proxy:port \
  -f dockerfiles/code-cli/Dockerfile \
  -t code-cli:latest \
  .
```

## Usage

### Run Interactively
```bash
docker run -it --rm code-cli:latest
```

### Run with Workspace Mount
```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  code-cli:latest
```

### Run with Config Files
Create a settings directory with your config files:

```bash
mkdir -p settings/claude settings/codex settings/opencode

# Add your config files
docker run -it --rm \
  -v $(pwd)/settings/claude.json:/home/aiagent/.claude.json \
  -v $(pwd)/settings/claude:/home/aiagent/.claude \
  -v $(pwd)/settings/codex:/home/aiagent/.codex \
  -v $(pwd)/settings/opencode:/home/aiagent/.config/opencode \
  -v $(pwd):/workspace \
  code-cli:latest
```

## Configuration

### Config File Locations

| Tool | Config Path | Description |
|------|-------------|-------------|
| Claude Code | `~/.claude.json` | Main config |
| Claude Code | `~/.claude/settings.json` | Settings directory |
| Codex | `~/.codex/auth.json` | Authentication |
| Codex | `~/.codex/config.toml` | Configuration |
| Opencode | `~/.config/opencode/` | Full config directory |

### API Keys

Set these environment variables when running the container:

```bash
docker run -it --rm \
  -e ANTHROPIC_API_KEY=your_key_here \
  -e OPENAI_API_KEY=your_key_here \
  -e OPENCODE_API_KEY=your_key_here \
  code-cli:latest
```

Or mount a `.env` file and source it in your shell.

## Example Commands

### Claude Code
```bash
# Start interactive session
claude

# Run a specific task
claude "Explain this codebase"

# Pass input via stdin
echo "Review this code" | claude --stdin
```

### OpenAI Codex
```bash
# Start interactive session
codex

# Run with full automation
codex --full-auto "Run tests and fix failures"

# Pass input via stdin
echo "Hi there" | codex --stdin
```

### Opencode
```bash
# Start interactive session
opencode

# Run a command
opencode "Generate a README for this project"

# Pass input via stdin
echo "Hi there" | opencode --stdin
```

## Container Details

| Property | Value |
|----------|-------|
| Base Image | `debian:bookworm-slim` |
| Default User | `aiagent` (UID 1000) |
| Default Shell | `zsh` |
| Home Directory | `/home/aiagent` |
| Workspace | `/workspace` |
| Python | 3.11 (via Miniforge) |
| Node.js | 20.x |

## Notes

- This image is built for **x86_64 (amd64)** architecture
- On Apple Silicon Macs, Docker Desktop will use emulation (Rosetta 2/QEMU)
- For better performance on ARM64, build a multi-platform image
- The `aiagent` user has sudo access for installing additional packages
