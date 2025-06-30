#!/bin/bash

# Chat logs management script
CHAT_DIR="$HOME/Desktop/warp_chat_logs"

echo "=== Chat Logs Status ==="
echo "Location: $CHAT_DIR"
echo

# Check if directory exists
if [ ! -d "$CHAT_DIR" ]; then
    echo "Chat logs directory not found!"
    exit 1
fi

# Show directory size
echo "Total size:"
du -sh "$CHAT_DIR"
echo

# Count files
FILE_COUNT=$(ls -1 "$CHAT_DIR"/*.txt 2>/dev/null | wc -l)
echo "Number of chat files: $FILE_COUNT"
echo

# Show recent files
if [ $FILE_COUNT -gt 0 ]; then
    echo "Recent chat files:"
    ls -lt "$CHAT_DIR"/*.txt 2>/dev/null | head -5
    echo
fi

# Show largest files if more than 10 files
if [ $FILE_COUNT -gt 10 ]; then
    echo "Largest files:"
    ls -lhS "$CHAT_DIR"/*.txt 2>/dev/null | head -3
fi
