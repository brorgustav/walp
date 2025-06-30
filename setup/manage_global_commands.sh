#!/bin/bash

# Warp Chat Logger - Global Commands Manager
# This script can install or uninstall the global warp-log commands

SCRIPT_DIR="$(dirname "$0")"
INSTALL_DIR="$(dirname "$SCRIPT_DIR")"

show_help() {
    echo "Warp Chat Logger - Global Commands Manager"
    echo "=========================================="
    echo
    echo "Usage: $0 [install|uninstall|status|welcome]"
    echo
    echo "Commands:"
    echo "  install   - Add global warp-log commands to your shell"
    echo "  uninstall - Remove global warp-log commands from your shell"
    echo "  status    - Check if global commands are installed"
    echo "  welcome   - Add/remove welcome message that shows commands"
    echo
    echo "Global commands that will be available:"
echo "  walp log \"description\"  - Create new chat log from anywhere"
echo "  walp status            - Check logs status from anywhere"
echo "  walp logs              - Show location and status"
}

get_shell_profile() {
    if [ -f "$HOME/.bash_profile" ]; then
        echo "$HOME/.bash_profile"
    elif [ -f "$HOME/.bashrc" ]; then
        echo "$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
        echo "$HOME/.zshrc"
    else
        echo "$HOME/.bash_profile"  # Default to create
    fi
}

install_commands() {
    SHELL_PROFILE=$(get_shell_profile)
    
    # Check if already installed
    if grep -q "WARP_LOGGER_PATH" "$SHELL_PROFILE" 2>/dev/null; then
        echo "⚠️  Global commands appear to already be installed."
        echo "Shell profile: $SHELL_PROFILE"
        read -p "Continue anyway? This may create duplicates. (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Installation cancelled."
            return 1
        fi
    fi
    
    echo "Installing global commands to: $SHELL_PROFILE"
    
    # Create profile file if it doesn't exist
    touch "$SHELL_PROFILE"
    
    # Add the global commands
    cat >> "$SHELL_PROFILE" << EOF

# Warp Chat Logger - Added on $(date)
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
    
    echo "✅ Global commands installed successfully!"
    echo "🔄 Restart your terminal or run: source $SHELL_PROFILE"
    echo
    echo "📝 Available commands:"
    echo "   walp log \"description\"  - Create new chat log from anywhere"
    echo "   walp status            - Check logs status from anywhere"
    echo "   walp logs              - Show location and status"
}

uninstall_commands() {
    SHELL_PROFILE=$(get_shell_profile)
    
    if [ ! -f "$SHELL_PROFILE" ]; then
        echo "❌ Shell profile not found: $SHELL_PROFILE"
        return 1
    fi
    
    if ! grep -q "WARP_LOGGER_PATH" "$SHELL_PROFILE"; then
        echo "ℹ️  Global commands don't appear to be installed."
        return 0
    fi
    
    echo "Removing global commands from: $SHELL_PROFILE"
    
    # Create a backup
    cp "$SHELL_PROFILE" "$SHELL_PROFILE.warp-backup-$(date +%Y%m%d-%H%M%S)"
    
    # Remove the Warp Chat Logger section
    # This removes from the comment line to the last warp command
    sed -i '' '/# Warp Chat Logger - Added/,/^}$/d' "$SHELL_PROFILE"
    
    echo "✅ Global commands removed successfully!"
    echo "📁 Backup created: $SHELL_PROFILE.warp-backup-*"
    echo "🔄 Restart your terminal for changes to take effect"
}

check_status() {
    SHELL_PROFILE=$(get_shell_profile)
    
    echo "Shell profile: $SHELL_PROFILE"
    echo "Install directory: $INSTALL_DIR"
    echo
    
    if [ -f "$SHELL_PROFILE" ] && grep -q "WARP_LOGGER_PATH" "$SHELL_PROFILE"; then
        echo "✅ Global commands are installed"
        
        if grep -q "warp_welcome" "$SHELL_PROFILE"; then
            echo "✅ Welcome message is enabled"
        else
            echo "❌ Welcome message is disabled"
        fi
        
        echo
        echo "Available commands:"
        echo "  walp log \"description\""
        echo "  walp status"
        echo "  walp logs"
    else
        echo "❌ Global commands are not installed"
        echo
        echo "Run '$0 install' to install them"
    fi
}

manage_welcome() {
    SHELL_PROFILE=$(get_shell_profile)
    
    if [ ! -f "$SHELL_PROFILE" ] || ! grep -q "WARP_LOGGER_PATH" "$SHELL_PROFILE"; then
        echo "❌ Global commands must be installed first!"
        echo "Run '$0 install' to install global commands."
        return 1
    fi
    
    if grep -q "warp_welcome" "$SHELL_PROFILE"; then
        echo "💬 Welcome message is currently enabled."
        echo "This shows warp-log commands every time you open a terminal."
        echo
        read -p "Would you like to disable it? (y/N): " -n 1 -r
        echo
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Create backup
            cp "$SHELL_PROFILE" "$SHELL_PROFILE.warp-backup-$(date +%Y%m%d-%H%M%S)"
            
            # Remove welcome message section
            sed -i '' '/# Warp Chat Logger Welcome Message/,/^warp_welcome$/d' "$SHELL_PROFILE"
            
            echo "✅ Welcome message disabled!"
            echo "📁 Backup created: $SHELL_PROFILE.warp-backup-*"
            echo "🔄 Restart your terminal for changes to take effect"
        else
            echo "⏭️  Welcome message kept enabled."
        fi
    else
        echo "💬 Welcome message is currently disabled."
        echo "This would show warp-log commands every time you open a terminal."
        echo
        read -p "Would you like to enable it? (y/N): " -n 1 -r
        echo
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Add welcome message
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
            
            echo "✅ Welcome message enabled!"
            echo "🔄 Restart your terminal to see the welcome message"
        else
            echo "⏭️  Welcome message kept disabled."
        fi
    fi
}

# Main script logic
case "${1:-help}" in
    install)
        install_commands
        ;;
    uninstall)
        uninstall_commands
        ;;
    status)
        check_status
        ;;
    welcome)
        manage_welcome
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        echo
        show_help
        exit 1
        ;;
esac
