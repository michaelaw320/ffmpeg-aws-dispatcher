#!/bin/bash

# Change to current script dir
cd "$(dirname "$0")"

PROJECT_PATH="$1"
INPUT_PATH="$2"
OUTPUT_PATH="$3"
FFMPEG_PATH="$4"

# Set variables according to parameter
source "$PROJECT_PATH/EncoderConfiguration.txt"

case $video_codec in
    "h264") ENCODER_SCRIPT="./H264Encoder.sh";;
    "h265") ENCODER_SCRIPT="./H265Encoder.sh";;
    *) ENCODER_SCRIPT="./NullHandler.sh";;
esac

# Pass the video options to Script for further processing
if [ $video_codec == "h264" ] || [ $video_codec == "h265" ]
then
    VIDEO_OPTION="-p $video_preset -c $video_crf -r $video_resize -w $video_resize_w -h $video_resize_h -z $video_resizer -d $video_deinterlace"
fi

# Audio parameters for ffmpeg directly configured here
case $audio_codec in
    "flac") AUDIO_OPTION="flac -compression_level 12";;
    *) AUDIO_OPTION="copy";;
esac

# Execute encoding loop
readarray inputs < "$PROJECT_PATH/InputFiles.txt"
readarray outputs < "$PROJECT_PATH/OutputFiles.txt"

for (( i=0; i<${#inputs[@]}; i++ ));
do
    "$ENCODER_SCRIPT" -f "$FFMPEG_PATH" -i "$INPUT_PATH/$(echo ${inputs[$i]} | tr -d '\r\n')" -o "$OUTPUT_PATH/$(echo ${outputs[$i]} | tr -d '\r\n')" $VIDEO_OPTION -a "$AUDIO_OPTION"
done
