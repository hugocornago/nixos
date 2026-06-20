#!/bin/sh
set -eo pipefail
function get_last_created_clip() {
  find ~/Videos/steam/clips -type d -path '*/video/*' -printf '%T@ %p\n' \
    | sort -nr \
    | head -n1 \
    | cut -d' ' -f2-
}

LAST=`get_last_created_clip`
VIDEO=`mktemp --suffix .mp4`

pushd $LAST
cat init-stream0.m4s chunk-stream0*.m4s > video.mp4
cat init-stream1.m4s chunk-stream1*.m4s > audio.mp4
ffmpeg -y -i video.mp4 -i audio.mp4 -c copy "$VIDEO"
rm -f video.mp4 audio.mp4
notify-send "Clip created. Uploading to server"
share.sh $VIDEO
