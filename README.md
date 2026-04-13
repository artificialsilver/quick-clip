# quick-clip 📋

A minimalist, high-performance CLI snippet manager designed for developers and researchers. Save frequently used strings, long commands, or blockchain addresses with short aliases and copy them directly to your system clipboard instantly.

## 🌟 Key Features

- **Shell Agnostic**: Works seamlessly across `zsh`, `bash`, `fish`, and others.
- **Auto-Detect Display Server**: Intelligent support for both **Wayland** (`wl-copy`) and **X11** (`xclip`).
- **Global Command**: Installed in `/usr/local/bin`, making it accessible from any directory.
- **Lightweight**: Zero heavy dependencies. Uses a simple flat-file storage (`~/.clip_storage`).

## 🚀 Installation

You can install `clip` using the following one-liner script:

```bash
# 1. Download the installer
curl -sSL [https://raw.githubusercontent.com/YOUR_USERNAME/clip-alias/main/install.sh](https://raw.githubusercontent.com/YOUR_USERNAME/clip-alias/main/install.sh) -o install.sh

# 2. Make it executable
chmod +x install.sh

# 3. Run the installer
./install.sh
