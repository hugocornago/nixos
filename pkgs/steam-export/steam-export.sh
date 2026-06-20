#!/bin/sh
function get_last_created_clip() {
  find ~/Videos/steam/clips -type d -path '*/video/*' -printf '%T@ %p\n' \
    | sort -nr \
    | head -n1 \
    | cut -d' ' -f2-
}

LAST=`get_last_created_clip`
VIDEO=`mktemp --suffix .mp4`

pushd $LAST
ffmpeg -y -i session.mpd "$VIDEO"
notify-send "Clip created. Uploading to server"
share.sh $VIDEO
