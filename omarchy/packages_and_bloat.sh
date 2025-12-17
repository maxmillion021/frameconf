#!/bin/bash

# Default configuration file path
CONFIG_FILE="uninstall_bloat.conf"
PACKAGE_FILE="packages.conf"

# Function to display usage instructions
usage() {
    echo "Usage: $0 [config_file_path]"
    echo "Uninstalls bloat listed in the configuration file."
    echo "If no config file is specified, uses $CONFIG_FILE by default."
    exit 1
}

# Check if running with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo or as root"
    exit 1
fi

# Allow optional config file path as argument
if [ $# -eq 1 ]; then
    CONFIG_FILE="$1"
fi

# Check if configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file $CONFIG_FILE not found"
    exit 1
fi

# Check if packages file exists
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Error: Configuration file $PACKAGE_FILE not found"
    exit 1
fi
# List to store bloat that couldn't be removed
failed_packages=()
installed_packages=()

# Read bloat from configuration file
# Ignore comment lines (starting with #) and empty lines
bloat=$(grep -v '^\s*#' "$CONFIG_FILE" | grep -v '^\s*$')
packages=$(grep -v '^\s*#' "$PACKAGE_FILE" | grep -v '^\s*$')

# Check if any bloat are found in the config file
if [ -z "$bloat" ]; then
    echo "No bloat found in the configuration file"
    exit 1
fi

# Attempt to remove each package
while read -r bloat; do
    echo "Attempting to remove package: $bloat"
    pacman -R --noconfirm "$bloat"
    
    # Check if package removal was successful
    if [ $? -ne 0 ]; then
        echo "Failed to remove package: $bloat"
        failed_packages+=("$bloat")
    fi
done <<< "$bloat"

# Report on failed bloat
if [ ${#failed_packages[@]} -ne 0 ]; then
    echo "The following bloat could not be removed:"
    printf '%s\n' "${failed_packages[@]}"
else
    echo "All specified bloat were successfully removed."
fi


# Attempt to remove each package
while read -r packages; do
    echo "Attempting to remove package: $packages"
    pacman -S --noconfirm --needed "$packages"
    # Check if package removal was successful
    if [ $? -ne 0 ]; then
        echo "Failed to remove package: $packages"
        installed_packages+=("$packages")
    fi
done <<< "$packages"
