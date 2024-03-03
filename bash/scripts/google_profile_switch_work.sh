#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title google_profile_switch_work
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author obidan
# @raycast.authorURL https://raycast.com/obidan



# Define the Chrome profile name to switch to
TARGET_PROFILE="Default"

# Create a temporary file to store window titles
tmpfile="./file.txt"
touch "$tmpfile"

# Use AppleScript to activate the Chrome window with the specified profile
osascript -e 'tell application "Google Chrome"
    activate
    set targetProfileWindows to {}
    set allWindows to every window
    repeat with aWindow in allWindows
        set windowTitle to do shell script "echo \"" & (title of aWindow) & "\""
        if windowTitle contains "'"$TARGET_PROFILE"'" then
            set targetProfileWindows to targetProfileWindows & {aWindow}
        end if
    end repeat
    if (count of targetProfileWindows) > 0 then
        set active tab index of item 1 of targetProfileWindows to 1
        set index of item 1 of targetProfileWindows to 1
    end if
end tell' > "$tmpfile"



# Remove the temporary file



# # Check if the Chrome profile directory exists
# CHROME_PROFILE_DIR="$HOME/Library/Application Support/Google/Chrome/$WORK_PROFILE"
# if [ -d "$CHROME_PROFILE_DIR" ]; then
#     # Use AppleScript to activate the Chrome window with the specified profile
#     osascript <<EOF
#     tell application "Google Chrome"
#         activate
#         set foundWindow to false
#         repeat with aWindow in windows
#             if name of aWindow contains "$WORK_PROFILE" then
#                 set index of aWindow to 1
#                 set foundWindow to true
#                 exit repeat
#             end if
#         end repeat
#         if not foundWindow then
#             set newWindow to make new window
#             set URL of active tab of newWindow to "chrome://newtab"
#         end if
#     end tell
# EOF
# else
#     # If the Chrome profile directory does not exist, open Chrome with the specified profile and restore the last session
#     open -na "Google Chrome" --args --profile-directory="$WORK_PROFILE" --restore-last-session
# fi