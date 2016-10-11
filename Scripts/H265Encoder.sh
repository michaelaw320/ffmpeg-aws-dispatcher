#!/bin/bash

while getopts ":f:i:o:a:p:c:r:w:h:z:d:" opt; do
  case $opt in
    f) FFMPEG_BIN="$OPTARG/ffmpeg";;
    i) FileName="$OPTARG";;
    o) OutputName="$OPTARG";;
    a) AUDIO_OPTION="$OPTARG";;
    p) PARAM_PRESET="$OPTARG";;
    c) PARAM_CRF="$OPTARG";;
    r) Resize="$OPTARG";;
    w) RESIZE_W="$OPTARG";;
    h) RESIZE_H="$OPTARG";;
    z) RESIZER="$OPTARG";;
    d) DEINTERLACE="$OPTARG";;
    \?) echo "Invalid option: -$OPTARG" ;;
  esac
done

# Resize? Yes = 1, No = 0

#Build video option string
VIDEO_OPT_STR="-c:v libx265 -preset $PARAM_PRESET -x265-params crf=$PARAM_CRF"

#Build video filter option string
FILTER_OPT=""
if [ $Resize == "1" ]
then
    FILTER_OPT="-vf $FILTER_OPT scale=$RESIZE_W:$RESIZE_H:flags=$RESIZER"
fi

DEINTERLACE_FLAG=""
if [ $DEINTERLACE == "1" ]
then
    DEINTERLACE_FLAG="-deinterlace"
fi

"$FFMPEG_BIN" -hide_banner -ss 0 -i "$FileName" $DEINTERLACE_FLAG $FILTER_OPT $VIDEO_OPT_STR -c:a $AUDIO_OPTION -scodec copy "$OutputName"

