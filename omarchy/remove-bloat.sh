#!/bin/bash

# Default configuration file path
CONFIG_FILE="uninstall_bloat.conf"

# Function to display usage instructions
usage() {
    echo "Usage: $0 [config_file_path]"
    echo "Uninstalls packages listed in the configuration file."
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

# List to store packages that couldn't be removed
failed_packages=()

# Read packages from configuration file
# Ignore comment lines (starting with #) and empty lines
packages=$(grep -v '^\s*#' "$CONFIG_FILE" | grep -v '^\s*$')

# Check if any packages are found in the config file
if [ -z "$packages" ]; then
    echo "No packages found in the configuration file"
    exit 1
fi

# Attempt to remove each package
while read -r package; do
    echo "Attempting to remove package: $package"
    pacman -R --noconfirm "$package"
    
    # Check if package removal was successful
    if [ $? -ne 0 ]; then
        echo "Failed to remove package: $package"
        failed_packages+=("$package")
    fi
done <<< "$packages"

# Report on failed packages
if [ ${#failed_packages[@]} -ne 0 ]; then
    echo "The following packages could not be removed:"
    printf '%s\n' "${failed_packages[@]}"
    exit 1
else
    echo "All specified packages were successfully removed."
fi
