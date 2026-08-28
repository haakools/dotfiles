#!/bin/bash
# Installing required packages
sudo apt install rofi picom nitrogen neofetch

DOTFILES_DIR=$(git rev-parse --show-toplevel)

# Function to create a clean symlink by removing the target first
create_symlink() {
    local source=$1
    local target=$2
    
    echo "Setting up symlink for $target"
    
    # Remove the target if it exists (whether it's a file, directory, or symlink)
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "  Removing existing target: $target"
        rm -rf "$target"
    fi
    
    # Create the parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Create the new symlink
    echo "  Creating new symlink: $source -> $target"
    ln -s "$source" "$target"
}

# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Setup nvim configuration
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Setup tmux configuration
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Setup aliases. Requires sourcing ~/aliases.sh in ~/.bashrc
create_symlink "$DOTFILES_DIR/aliases.sh" "$HOME/.bash_aliases"

# Setup rofi configuration
create_symlink "$DOTFILES_DIR/rofi" "$HOME/.config/rofi"

# Setup picom configuration
create_symlink "$DOTFILES_DIR/picom.conf" "$HOME/.config/picom/picom.conf"

# Setup nitrogen (wallpaper manager) configuration
create_symlink "$DOTFILES_DIR/nitrogen" "$HOME/.config/nitrogen"

# Setup neofetch configuration
create_symlink "$DOTFILES_DIR/neofetch" "$HOME/.config/neofetch"

# Setup Claude Code settings, statusline, skills, notify hook, and sounds
create_symlink "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
create_symlink "$DOTFILES_DIR/.claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
create_symlink "$DOTFILES_DIR/.claude/skills" "$HOME/.claude/skills"
create_symlink "$DOTFILES_DIR/.claude/notify.sh" "$HOME/.claude/notify.sh"
create_symlink "$DOTFILES_DIR/.claude/sounds" "$HOME/.claude/sounds"

# Setup Claude Code settings, statusline, skills, notify hook, and sounds
# for the work/personal account profiles (see claude-work/claude-personal
# aliases in aliases.sh). Note: settings.json hardcodes $HOME/.claude for
# notify.sh/statusline-command.sh/sounds, so these per-profile symlinks are
# only exercised if that ever changes to use $CLAUDE_CONFIG_DIR instead.
for profile in work personal; do
    create_symlink "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude-$profile/settings.json"
    create_symlink "$DOTFILES_DIR/.claude/statusline-command.sh" "$HOME/.claude-$profile/statusline-command.sh"
    create_symlink "$DOTFILES_DIR/.claude/skills" "$HOME/.claude-$profile/skills"
    create_symlink "$DOTFILES_DIR/.claude/notify.sh" "$HOME/.claude-$profile/notify.sh"
    create_symlink "$DOTFILES_DIR/.claude/sounds" "$HOME/.claude-$profile/sounds"
done

# Set GNOME keyboard shortcuts for rofi
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Rofi Launcher"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "rofi -show drun"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "Super_L"

# Make sure we have the directories for the symlinks
mkdir -p "$DOTFILES_DIR/rofi"
mkdir -p "$DOTFILES_DIR/neofetch"
mkdir -p "$DOTFILES_DIR/nitrogen"

echo "Setup completed! All existing symlinks were removed and clean symlinks have been created."
