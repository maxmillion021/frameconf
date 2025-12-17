#!/bin/bash
set -eu  # Exit on errors and undefined variables

# Determine script and source directories more robustly
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$(dirname "$SCRIPT_DIR")"

# Configuration paths
HOME_CONFIG="$HOME/.config"
HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"

# Logging function
log() {
    printf "\033[32m[+]\033[0m %s\n" "$1"
}

# Error handling function
error() {
    printf "\033[31m[!]\033[0m %s\n" "$1" >&2
    exit 1
}

# Safe symlink creation function
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Remove existing file/link if it exists
    [ -L "$target" ] && rm -f "$target"
    [ -f "$target" ] && rm -f "$target"
    [ -d "$target" ] && rm -rf "$target"
    
    # Create symlink
    if ln -s "$source" "$target" 2>/dev/null; then
        log "Created symlink: $target"
    else
        error "Failed to create symlink: $target"
    fi
}

# Cleanup and configuration setup
main() {
    # Ensure target directories exist
    mkdir -p "$HOME_CONFIG/hypr"

    # Define configuration mappings
    declare -A configs=(
        ["$HOME/.bashrc"]="${SOURCE_DIR}/bashrc/bashrc"
        ["$HOME_CONFIG/kitty"]="${SOURCE_DIR}/kitty"
        ["$HOME_CONFIG/starship"]="${SOURCE_DIR}/starship"
        ["$HOME_CONFIG/tmux"]="${SOURCE_DIR}/tmux"
        ["$HOME_CONFIG/hypr/omarchy_override.conf"]="${SOURCE_DIR}/omarchy/omarchy_override.conf"
    )

    # Create symlinks
    for target in "${!configs[@]}"; do
        source="${configs[$target]}"
        
        # Check if source exists
        [ -e "$source" ] || error "Source does not exist: $source"
        
        # Create symlink
        create_symlink "$source" "$target"
    done

    # Modify Hyprland configuration
    modify_hyprland_config
}

# Safely modify Hyprland configuration
modify_hyprland_config() {
    local override_line="source = ~/.config/hypr/omarchy_override.conf"
    
    # Ensure Hyprland config exists
    [ -f "$HYPRLAND_CONFIG" ] || error "Hyprland config not found: $HYPRLAND_CONFIG"
    
    # Check if source line already exists
    if ! grep -Fxq "$override_line" "$HYPRLAND_CONFIG"; then
        echo "" >> "$HYPRLAND_CONFIG"
        echo "# omarchy_override" >> "$HYPRLAND_CONFIG"
        echo "$override_line" >> "$HYPRLAND_CONFIG"
        log "Added override to Hyprland config"
    else
        log "Override already exists in Hyprland config"
    fi
}

# Execute main function
main

# install packages
source packages.sh
