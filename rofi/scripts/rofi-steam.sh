#!/bin/bash

# Fixed path for Flatpak Steam
STEAM_DIR="\$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common"

# Check if directory exists
if [ ! -d "\$STEAM_DIR" ]; then
    echo "Steam games directory not found at \$STEAM_DIR"
    exit 1
fi

# List games or launch selected game
if [ -z "\$1" ]; then
    # Just list game directories
    find "\$STEAM_DIR" -maxdepth 1 -type d | grep -v "^\$STEAM_DIR\$" | sort | sed 's|.*/||'
else
    # Launch the selected game
    flatpak run com.valvesoftware.Steam "steam://run/\$1"
fi

