#!/bin/bash

# Warp Chat Logger Install Script
# Version 1.0
# This script sets up the Warp Chat Logger on your system.

set -e  # Exit on any error

echo "=========================================="
echo "    Warp Chat Logger Installer v1.0"
echo "=========================================="
echo

# Default installation directory (in current working directory)
DEFAULT_DIR="$(pwd)/walp_build"

echo "This will install the Warp Chat Logger system."
echo "Default installation location: $DEFAULT_DIR"
echo
read -p "Press Enter to continue with default location, or type a custom path: " CUSTOM_DIR

if [ -n "$CUSTOM_DIR" ]; then
    INSTALL_DIR="$CUSTOM_DIR"
else
    INSTALL_DIR="$DEFAULT_DIR"
fi

echo
echo "Installing to: $INSTALL_DIR"
echo
LOGS_DIR="$INSTALL_DIR/walp_logs"
# Check if directory already exists
if [ -d "$INSTALL_DIR" ]; then
    echo "⚠️  Directory already exists: $INSTALL_DIR"
    read -p "Continue anyway? This may overwrite existing files. (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

echo "Creating directories..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/setup"
mkdir -p "$INSTALL_DIR/walp_logs"


echo "Copying files..."
# Check if source files exist
if [ ! -f "log.sh" ]; then
    echo "❌ Error: Source files not found. Make sure you're running this from the warp-chat-logger directory."
    exit 1
fi

# Copy main scripts
cp log.sh "$INSTALL_DIR/"
cp status.sh "$INSTALL_DIR/"
cp log_chat.sh "$INSTALL_DIR/"
cp README.md "$INSTALL_DIR/"

# Copy setup files
cp setup/check_logs.sh "$INSTALL_DIR/setup/"
cp setup/README.txt "$INSTALL_DIR/setup/"

# Make scripts executable
chmod +x "$INSTALL_DIR/log.sh"
chmod +x "$INSTALL_DIR/status.sh"
chmod +x "$INSTALL_DIR/log_chat.sh"
chmod +x "$INSTALL_DIR/setup/check_logs.sh"

echo
echo "✅ Warp Chat Logger installed successfully!"
echo
echo "📂 Installation location: $INSTALL_DIR"
echo

# Ask about global command installation
echo "🌍 Would you like to install global commands?"
echo "This will add 'walp' command with subcommands to your shell."
echo "You'll be able to run 'walp log', 'walp status', etc. from anywhere."
echo
read -p "Install global commands? (y/N): " -n 1 -r
echo
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing global commands..."
    
    # Determine the shell profile file
    SHELL_PROFILE=""
    if [ -f "$HOME/.bash_profile" ]; then
        SHELL_PROFILE="$HOME/.bash_profile"
    elif [ -f "$HOME/.bashrc" ]; then
        SHELL_PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
        SHELL_PROFILE="$HOME/.zshrc"
    else
        # Create .bash_profile if none exist
        SHELL_PROFILE="$HOME/.bash_profile"
        touch "$SHELL_PROFILE"
    fi
    
    # Create the global commands
    cat >> "$SHELL_PROFILE" << EOF

# Warp Chat Logger - Added by installer on $(date)
export WARP_LOGGER_PATH="$INSTALL_DIR"
walp() {
    case "\$1" in
        log)
            if [ -z "\$2" ]; then
                echo "Usage: walp log \"description of chat\""
                return 1
            fi
            (cd "\$WARP_LOGGER_PATH" && ./log.sh "\$2")
            ;;
        status)
            (cd "\$WARP_LOGGER_PATH" && ./status.sh)
            ;;
        logs)
            echo "📂 Chat logs location: \$WARP_LOGGER_PATH"
            (cd "\$WARP_LOGGER_PATH" && ./status.sh)
            ;;
        --help|-h|help)
            echo "Warp Chat Logger - Global Commands"
            echo "Usage: walp [command] [options]"
            echo ""
            echo "Commands:"
            echo "  log \"description\"  - Create new chat log"
            echo "  status             - Check logs status"
            echo "  logs               - Show location and status"
            echo "  help               - Show this help"
            ;;
        *)
            echo "❌ Unknown command: \$1"
            echo "Run 'walp help' for usage information"
            return 1
            ;;
    esac
}
EOF
    
    echo "✅ Global commands added to $SHELL_PROFILE"
    echo "🔄 Restart your terminal or run: source $SHELL_PROFILE"
    echo
    echo "📝 New global commands available:"
    echo "   walp log \"description\"  - Create new chat log from anywhere"
    echo "   walp status            - Check logs status from anywhere"
    echo "   walp logs              - Show location and status"
    
    # Ask about welcome message
    echo
    echo "💬 Would you like to add a welcome message?"
    echo "This will show available warp-log commands every time you open a terminal."
    read -p "Add welcome message? (y/N): " -n 1 -r
    echo
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Add welcome message function
        cat >> "$SHELL_PROFILE" << 'EOF'

# Warp Chat Logger Welcome Message
warp_welcome() {
    echo "📝 Warp Chat Logger commands available:"
    echo "   walp log \"description\"  - Create new chat log"
    echo "   walp status            - Check logs status"
    echo "   walp logs              - Show location and status"
    echo
}

# Show welcome message on terminal start
warp_welcome
EOF
        echo "✅ Welcome message added! You'll see commands every time you open a terminal."
    else
        echo "⏭️  Skipped welcome message."
    fi
else
    echo "⏭️  Skipped global commands installation."
fi

echo
echo "🚀 Quick start:"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "   walp log \"my first chat log\"  (from anywhere after restart)"
    echo "   OR"
fi
echo "   cd \"$INSTALL_DIR\""
echo "   ./log.sh \"my first chat log\""
echo
echo "📚 For more info, check the README.md in the installation folder."
echo
echo "Happy logging! 🎉"

source "$SHELL_PROFILE"
