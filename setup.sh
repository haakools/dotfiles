#!/bin/bash


# get
DOTFILES_DIR=$(git rev-parse --show-toplevel)

mkdir -p ~/.config

create_symlink() {
    local source=$1
    local target=$2
    
    echo "Creating symlink for $target"
    # -f flag to overwrite existing files without prompting
    ln -sf "$source" "$target"
}

# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Setup nvim configuration
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Setup tmux configuration
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Setup aliases. Requires sourcing ~/aliases.sh in ~/.bashrc
create_symlink "$DOTFILES_DIR/aliases.sh" "$HOME/aliases.sh"

echo "Setup completed! Symlinks have been created."

