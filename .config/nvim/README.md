# Neovim Configuration

Modular Neovim config built on [lazy.nvim](https://github.com/folke/lazy.nvim), originally derived from kickstart.nvim.

## Structure

```
nvim/
├── init.lua              # Bootstrap: leaders, lazy.nvim install, plugin loader
├── lua/
│   ├── config/
│   │   ├── options.lua   # Core vim options, provider setup, nerd font flag
│   │   └── keymaps.lua   # Global keybindings (non-plugin)
│   ├── core/
│   │   ├── lsp.lua       # LSP servers (vim.lsp.config/enable), Mason
│   │   ├── autocomplete.lua  # blink.cmp completion engine
│   │   ├── autoformat.lua    # conform.nvim formatting
│   │   ├── telescope.lua     # Telescope + fzf-native + ui-select
│   │   └── treesitter.lua    # nvim-treesitter (parser management)
│   └── plugins/
│       ├── which_key.lua     # which-key.nvim v3 group prefixes
│       ├── theme.lua         # Rose Pine Moon colorscheme
│       ├── tree.lua          # nvim-tree file explorer
│       ├── debug.lua         # nvim-dap + dap-ui (Go debugger)
│       ├── jupyter.lua       # Molten + image.nvim + jupytext
│       ├── lint.lua          # nvim-lint (markdownlint, etc.)
│       ├── comment.lua       # (removed — using native gc/gcc)
│       └── presence.lua      # Discord presence
```

## Requirements

- Neovim >= 0.12
- git, make, gcc, ripgrep, fd
- A [Nerd Font](https://www.nerdfonts.com/) (JetBrainsMono recommended)
- Node.js (for JS/TS tooling)
- Go, Rust, Python as needed for language servers

## Usage

This config is managed as part of a dotfiles repo and symlinked to `~/.config/nvim`.

Plugins are installed automatically on first launch via lazy.nvim. Run `:Lazy` to view plugin status, `:Mason` to manage LSP servers and tools.
