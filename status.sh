#!/bin/bash
# Quick status check
echo "Chat logs folder size: $(du -sh . | cut -f1)"
echo "Number of chat files: $(ls -1 *.txt 2>/dev/null | wc -l | tr -d ' ')"
echo ""
echo "Recent files:"
ls -t *.txt 2>/dev/null | head -3
