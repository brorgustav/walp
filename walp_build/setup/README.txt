WARP CHAT LOGGING SYSTEM
========================

This folder contains your Warp chat conversation logs and management scripts.

USAGE:
------

1. To create a new chat log:
   ./log_chat.sh "description of conversation"
   
   Examples:
   ./log_chat.sh "debugging python script"
   ./log_chat.sh "setting up docker environment"
   ./log_chat.sh

2. To check your logs status and size:
   ./check_logs.sh

3. Manual logging:
   - You can also manually create .txt files in this folder
   - Use format: YYYY-MM-DD_HH-MM-SS_description.txt

FILES CREATED:
--------------
- Each chat gets a timestamped filename
- Format: 2024-06-30_13-17-30_description.txt
- Files open automatically in your default text editor

MONITORING SIZE:
---------------
- This folder is on your Desktop so you can see if it gets large
- Use check_logs.sh to see detailed size information
- Consider archiving old logs if the folder gets too big

TIPS:
-----
- Copy/paste your chat content into the generated files
- Include important commands and their outputs
- Add your own notes and context
- Keep descriptions brief but descriptive
