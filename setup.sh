#!/bin/bash

# Installing required packages
sudo apt install rofi picom nitrogen neofetch

DOTFILES_DIR=$(git rev-parse --show-toplevel)

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
create_symlink "$DOTFILES_DIR/aliases.sh" "$HOME/bash_aliases"

# Setup rofi configuration
ln -sfn "$DOTFILES_DIR/rofi" "$HOME/.config/rofi"

# Setup picom configuration
create_symlink "$DOTFILES_DIR/picom.conf" "$HOME/.config/picom/picom.conf"

# Setup nitrogen (wallpaper manager) configuration
create_symlink "$DOTFILES_DIR/nitrogen" "$HOME/.config/nitrogen"

# Setup neofetch configuration
create_symlink "$DOTFILES_DIR/neofetch" "$HOME/.config/neofetch"

# Set GNOME keyboard shortcuts for rofi
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Rofi Launcher"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "rofi -show drun"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "Super_L"

# Make sure we have the directories for the symlinks
mkdir -p "$DOTFILES_DIR/rofi"
mkdir -p "$DOTFILES_DIR/neofetch"
mkdir -p "$DOTFILES_DIR/nitrogen"

echo "Setup completed! Symlinks have been created."
