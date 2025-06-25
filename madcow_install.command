#!/usr/bin/env bash

# Madcow Installer

# Exit on error
set -e

MADCOW_DIR="$HOME/.madcow"
MADCOW_BIN_DIR="$MADCOW_DIR/bin"
# These URLs will point to the files within the 'madcow/bin' directory in the repo
MADCOW_LIB_URL="https://raw.githubusercontent.com/twardoch/madcow/master/madcow/bin/madcowlib"
MADCOW_SCRIPT_URL="https://raw.githubusercontent.com/twardoch/madcow/master/madcow/bin/madcow"


echo "Installing madcow..."

# Create necessary directories
mkdir -p "$MADCOW_BIN_DIR"
echo "Created directory $MADCOW_BIN_DIR"

# Download madcowlib
echo "Downloading madcowlib..."
if curl -fsSL "$MADCOW_LIB_URL" -o "$MADCOW_BIN_DIR/madcowlib"; then
    chmod +x "$MADCOW_BIN_DIR/madcowlib"
    echo "madcowlib downloaded successfully."
else
    echo "ERROR: Failed to download madcowlib from $MADCOW_LIB_URL"
    echo "Please check the URL and your internet connection."
    exit 1
fi

# Download main madcow script
echo "Downloading madcow script..."
if curl -fsSL "$MADCOW_SCRIPT_URL" -o "$MADCOW_BIN_DIR/madcow"; then
    chmod +x "$MADCOW_BIN_DIR/madcow"
    echo "madcow script downloaded successfully."
else
    echo "WARNING: Failed to download the main 'madcow' script from $MADCOW_SCRIPT_URL."
    echo "This might be because the script hasn't been added to the repository yet."
    echo "A placeholder 'madcow' script will be created."
    echo "You may need to re-run this installer later or manually place the 'madcow' script in $MADCOW_BIN_DIR."

    # Create a placeholder madcow script
    cat << 'EOF' > "$MADCOW_BIN_DIR/madcow"
#!/usr/bin/env bash
# Placeholder for madcow main script

echo "Madcow is partially installed."
echo "The main 'madcow' script was not found in the repository during installation."

MADCOW_LIB_PATH="$HOME/.madcow/bin/madcowlib"

if [ -f "$MADCOW_LIB_PATH" ]; then
    source "$MADCOW_LIB_PATH"

    echo ""
    # Assuming pp is available from madcowlib, otherwise use standard echo
    if command -v pp > /dev/null; then
        pp "[Madcow - Preliminary Help]"
    else
        echo "[Madcow - Preliminary Help]"
    fi
    echo "This is a placeholder script. Some functionalities might be missing."
    echo ""
    echo "Usage: madcow <command>"
    echo ""
    echo "Potential commands (once fully installed):"
    echo "  install [spec_file]   Install packages from a spec file."
    echo "  list                  List items (e.g., in a spec file or available specs)."
    echo "  help                  Show this help message."
    echo ""
    echo "Please ensure the 'madcow' script from 'madcow/bin/madcow' in the repository"
    echo "is correctly downloaded to $MADCOW_BIN_DIR/madcow."
    echo "You might need to re-run the installer: bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/twardoch/madcow/master/madcow_install.command)\""

else
    echo "ERROR: madcowlib not found at $MADCOW_LIB_PATH."
    echo "Installation is incomplete."
fi
EOF
    chmod +x "$MADCOW_BIN_DIR/madcow"
    echo "Placeholder 'madcow' script created at $MADCOW_BIN_DIR/madcow."
fi

echo ""
echo "madcow installation/update process complete."
echo ""
echo "IMPORTANT: Please add $MADCOW_BIN_DIR to your PATH if it's not already."
echo "You can do this by adding the following line to your shell configuration file"
echo "(e.g., ~/.bashrc, ~/.zshrc, or ~/.config/fish/config.fish):"
echo ""
echo "  export PATH=\"$MADCOW_BIN_DIR:\$PATH\""
echo ""
echo "After adding it, please restart your shell or source your configuration file (e.g., 'source ~/.bashrc')."
echo "Then, try running 'madcow help'."
