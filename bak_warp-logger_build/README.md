# Warp Chat Logger

A simple, organized system for logging and managing your Warp terminal AI chat conversations.

## Features

- ✅ **Easy logging**: Create timestamped chat log files with one command
- 📁 **Organized storage**: Clean folder structure in your working directory
- 📊 **Quick status**: Check storage usage and recent files instantly
- 🔧 **Simple setup**: One-command installation
- 🎯 **User-friendly**: Minimal commands for daily use

## Quick Install

1. Download or clone this repository
2. Run the installer:
   ```bash
   cd warp-chat-logger
   chmod +x install.sh
   ./install.sh
   ```
3. Follow the prompts (default installs to `./warp-logger_build`)

## Usage

After installation, navigate to your chat logs folder:

```bash
cd ./warp-logger_build
```

### Create a new chat log
```bash
./log.sh "debugging python script"
./log.sh "docker setup help"
./log.sh  # Creates generic timestamped log
```

### Check status
```bash
./status.sh
```

## Global Commands (Optional)

During installation, you can choose to install global commands that work from anywhere:

```bash
# Available globally after installation
warp-log "debugging session"     # Create log from any directory
warp-status                      # Check status from anywhere
warp-logs                        # Show location and status
```

**Managing global commands:**
```bash
# From your installation directory
cd ./warp-logger_build/setup
./manage_global_commands.sh install    # Install global commands
./manage_global_commands.sh uninstall  # Remove global commands
./manage_global_commands.sh status     # Check if installed
./manage_global_commands.sh welcome    # Enable/disable welcome message
```

**Welcome Message:**
Optionally show available commands every time you open a terminal:
```
📝 Warp Chat Logger commands available:
   warp-log "description"  - Create new chat log
   warp-status            - Check logs status
   warp-logs              - Show location and status
```

## File Structure

After installation:
```
./warp-logger_build/
├── README.md          # Quick reference
├── log.sh            # Create new chat logs
├── status.sh         # Check folder status
├── log_chat.sh       # Main logging engine
├── setup/            # Advanced management tools
│   ├── check_logs.sh # Detailed status/cleanup
│   └── README.txt    # Full documentation
└── *.txt             # Your chat log files
```

## How It Works

1. **Logging**: `log.sh` creates timestamped files like `2024-06-30_14-30-15_description.txt`
2. **Organization**: Files automatically open in your default text editor
3. **Monitoring**: Folder is in your working directory for easy access
4. **Management**: Advanced tools in `setup/` folder for maintenance

## Examples

```bash
# Daily usage examples
./log.sh "git workflow help"
./log.sh "react debugging session"
./log.sh "server deployment questions"

# Check your logs
./status.sh
# Output:
# Chat logs folder size: 1.2M
# Number of chat files: 8
# Recent files:
# 2024-06-30_14-30-15_git_workflow_help.txt
# 2024-06-30_13-45-20_react_debugging_session.txt
```

## Requirements

- macOS, Linux, or WSL
- Bash shell
- Basic text editor (opens automatically)

## Customization

- **Location**: Choose custom install location during setup
- **Editor**: Files open with your system's default text editor
- **Naming**: Modify `log_chat.sh` to change filename format

## Uninstall

Simply delete the installation folder:
```bash
rm -rf ./warp-logger_build
```

## Contributing

Feel free to submit improvements, bug fixes, or feature suggestions!

## License

Free to use and modify. Share with other Warp users!
