#!/bin/bash

source config.sh

CURRENT_DIR=$(pwd)

./Scripts/MainEncodeScript.sh "$CURRENT_DIR" "$CURRENT_DIR/SourceMedia" "$CURRENT_DIR/Result" "$CURRENT_DIR/ffmpeg-bin"
