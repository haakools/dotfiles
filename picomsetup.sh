#!/bin/bash

# Make sure picom is installed
if ! command -v picom &> /dev/null; then
    echo "Picom is not installed. Installing..."
    sudo apt install picom
fi

# Create config directory if it doesn't exist
mkdir -p ~/.config/picom

# The path to your picom.conf in your dotfiles repository
DOTFILES_DIR=$(git rev-parse --show-toplevel)
PICOM_CONF_SOURCE="$DOTFILES_DIR/picom.conf"

# Add picom to autostart if not already there
mkdir -p ~/.config/autostart
if [ ! -f ~/.config/autostart/picom.desktop ]; then
    cat > ~/.config/autostart/picom.desktop << EOF
[Desktop Entry]
Type=Application
Name=Picom
Comment=A lightweight compositor for X11
Exec=picom --config $HOME/.config/picom/picom.conf
StartupNotify=false
Terminal=false
Categories=System;
EOF
    echo "Added picom to autostart applications"
fi

# Restart picom if it's already running
if pgrep -x "picom" > /dev/null; then
    pkill -x picom
    sleep 1
fi
picom --config "$HOME/.config/picom/picom.conf" -b

echo "Picom configuration has been set up and service started"
