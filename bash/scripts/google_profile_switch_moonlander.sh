#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title google_profile_switch_moonlander
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author obidan
# @raycast.authorURL https://raycast.com/obidan

MOONLANDER_PROFILE="Profile 1"

CHROME_PROFILE_DIR="$HOME/Library/Application Support/Google/Chrome/$MOONLANDER_PROFILE"

if [ -d "$CHROME_PROFILE_DIR" ]; then
    open -a "Google Chrome" --args --profile-directory="$MOONLANDER_PROFILE"
else
    open -n -a "Google Chrome" --args --profile-directory="$MOONLANDER_PROFILE"
fi