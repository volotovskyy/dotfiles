#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title google_profile_switch_voyager
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author obidan
# @raycast.authorURL https://raycast.com/obidan

VOYAGER_PROFILE="Profile 2"

CHROME_PROFILE_DIR="$HOME/Library/Application Support/Google/Chrome/$VOYAGER_PROFILE"

if [ -d "$CHROME_PROFILE_DIR" ]; then
    open -a "Google Chrome" --args --profile-directory="$VOYAGER_PROFILE"
else
    open -n -a "Google Chrome" --args --profile-directory="$VOYAGER_PROFILE"
fi