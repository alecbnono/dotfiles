#!/bin/bash
# A script to reset Neovim to a "just-cloned" state

echo "Nuking Neovim cache and data..."

# Remove the plugin installations (lazy.nvim or packer)
rm -rf ~/.local/share/nvim

# Remove the state/cache (undo history, search history)
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

echo "Done. Your next nvim launch will be a fresh install."
