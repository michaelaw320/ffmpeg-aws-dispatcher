#!/bin/bash

cd "$(dirname "$0")"

source config.sh

# Execute the main encode script
"$AWS_PROJECTPATH/Scripts/MainEncodeScript.sh" "$AWS_PROJECTPATH" "$AWS_INPUTMEDIA" "$AWS_RESULT" "$AWS_FFMPEG_BIN"

# Execute custom scripts, all scripts in CustomScripts folder

# Push the result to dedi
scp -r -i "$MASTER_KEYPATH_ON_AWS" -P "$MASTER_PORT" "$AWS_RESULT" $MASTER_USER@$MASTER_ADDRESS:"\"$MASTER_PROJECTPATH\""

# Delete the EncodeAutomation Folder
rm -rf "$AWS_PROJECTPATH"

# Shutdown the instance
sudo shutdown -h now
