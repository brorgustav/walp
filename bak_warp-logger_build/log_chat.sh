#!/bin/bash

# Chat logging script for Warp conversations
# Usage: ./log_chat.sh "brief description of chat"

CHAT_DIR="$HOME/Desktop/warp_chat_logs"
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
DESCRIPTION=${1:-"general_chat"}

# Clean description for filename (remove spaces, special chars)
CLEAN_DESC=$(echo "$DESCRIPTION" | sed 's/[^a-zA-Z0-9]/_/g' | tr '[:upper:]' '[:lower:]')

FILENAME="${TIMESTAMP}_${CLEAN_DESC}.txt"
FILEPATH="$CHAT_DIR/$FILENAME"

# Create the log file with header
cat > "$FILEPATH" << EOF
=== Warp Chat Log ===
Date: $(date)
Description: $DESCRIPTION
File: $FILENAME

=== Chat Content ===
(Paste your chat content below this line)

EOF

echo "Created chat log: $FILEPATH"
echo "You can now paste your chat content into this file."

# Optional: Open the file in default text editor
if command -v open &> /dev/null; then
    echo "Opening file for editing..."
    open "$FILEPATH"
fi
