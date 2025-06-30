#!/bin/bash

# Demo script for Warp Chat Logger
# This shows what the system looks like after installation

echo "🚀 Warp Chat Logger Demo"
echo "========================"
echo

# Show the installer
echo "1. Installation is simple:"
echo "   ./install.sh"
echo

# Show usage examples
echo "2. After installation, daily usage is:"
echo "   cd ./warp-logger_build"
echo "   ./log.sh \"description of your chat\""
echo "   ./status.sh"
echo

# Show file structure
echo "3. File structure:"
tree -I '__pycache__|*.pyc' . 2>/dev/null || ls -la

echo
echo "4. The installed system will create timestamped files like:"
echo "   2024-06-30_14-30-15_debugging_python_script.txt"
echo "   2024-06-30_15-45-22_docker_setup_help.txt"
echo

echo "Ready to install? Run: ./install.sh"
