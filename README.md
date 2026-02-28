# 🌙 Alec's dotfiles

My personal dotfiles for a clean, productive, and aesthetically pleasing Linux development environment. Currently running on **Arch Linux** with **Hyprland** (and Niri experiment).

## ✨ Features
- **Theme:** Rose Pine Moon (consistent across Tmux, Hyprland, etc.)
- **WM:** [Hyprland](https://hyprland.org/) (Main) & [Niri](https://github.com/YaLTeR/niri) (Testing)
- **Bar:** [Waybar](https://github.com/Alexays/Waybar)
- **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
- **Editor:** [Neovim](https://neovim.io/) (Configured with Lazy.nvim)
- **Shell:** Bash + [Starship](https://starship.rs/)
- **Multiplexer:** [Tmux](https://github.com/tmux/tmux/wiki) (Plugins managed via TPM)
- **Launcher:** [Fuzzel](https://codeberg.org/dnkl/fuzzel) / [Wofi](https://hg.sr.ht/~scoopta/wofi)
- **Notifications:** [Mako](https://github.com/emersion/mako)

## 📁 Repository Structure
```
.
├── .bashrc              # Bash configuration & aliases
├── .config/             # XDG_CONFIG_HOME
│   ├── hypr/            # Hyprland, Hyprlock, Hypridle, Hyprpaper
│   ├── kitty/           # Terminal configuration
│   ├── nvim/            # Neovim setup (Lazy.nvim)
│   ├── starship/        # Prompt configuration
│   ├── tmux/            # Tmux specific config
│   └── waybar/          # Top bar configuration
├── .tmux.conf           # Tmux main configuration
├── scripts/             # Useful helper scripts
├── pkglist.txt          # Native Arch package list
└── aur_pkglist.txt      # AUR package list
```

## 🚀 Getting Started

### Prerequisites
Ensure you have the following installed (for Arch Linux users):
```bash
sudo pacman -S --needed < pkglist.txt
# For AUR packages
yay -S --needed < aur_pkglist.txt
```

### Installation
I recommend using a tool like `stow` or manually symlinking files to your `$HOME` or `~/.config` directory.

```bash
# Example manual symlink for hyprland
ln -s ~/dotfiles/.config/hypr ~/.config/hypr
```

### Neovim Setup
Neovim will automatically install plugins via `lazy.nvim` on the first run.
```bash
nvim
```

### Tmux Setup
After launching tmux, press `prefix + I` (default prefix is `Ctrl-b` unless changed) to install plugins via TPM.

## 🛠️ Custom Scripts
- `nvim-nuke.sh`: Resets Neovim state, cache, and plugins. (Also available as a bash function `nvim-nuke`).

## 🎨 Screenshots
*(Coming soon...)*
