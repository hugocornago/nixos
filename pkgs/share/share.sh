#!/bin/sh
# https://bash-prompt.net/guides/bash-set-options/
set -eo pipefail
# set -x

VIDEO=$1
NAME=$2

if [ -z $VIDEO ]; then
  echo "Usage: $0 [video] [name]"
  exit 1
fi

if [ -z $NAME ]; then
  NAME=`date +"%Y-%m-%d_%H-%M-%S"` # 2026-06-20_13-24-10
fi

IS_VIDEO=`file --mime-type -b "$VIDEO" | grep -E 'video/(mp4|matroska|x-matroska)'` 
if [ -z $IS_VIDEO ]; then
  echo "File specified is not a video."
  exit 1
fi

EXTENSION=`echo $VIDEO | awk -F . '{print $NF}'`
FULLNAME="$NAME.$EXTENSION"

# 0. Preencode the video
if [ `du -m $VIDEO | cut -f1` -gt 500 ]; then
  echo "Video is bigger than 500MB, encoding..."

  TMPFILE=$(mktemp --suffix .mp4)

  ffmpeg -y \
  -vaapi_device /dev/dri/renderD128 \
  -i "$VIDEO" \
  -vf 'format=nv12,hwupload' \
  -c:v h264_vaapi \
  -rc_mode CQP -qp 27 \
  -maxrate 4400k -bufsize 8800k \
  -c:a aac -b:a 128k \
  -movflags +faststart \
  "$TMPFILE"

  VIDEO=$TMPFILE
fi

# 1. Subir video a /storage/Videos/public/
rsync --no-perms -avPW "$VIDEO" "server:/storage/Videos/public/$FULLNAME"
ssh server "chown copyparty:storage /storage/Videos/public/$FULLNAME"
# scp "$VIDEO" "server:/storage/Videos/public/$FULLNAME"

# 2. Crear el share link (custom)
SHARE="https://files.cornago.net/shares/videos/$FULLNAME"

# 4. Copiar al clipboard
if [ "$XDG_SESSION_TYPE" == "x11" ]; then
  echo $SHARE | xclip -selection clipboard
elif [ "$XDG_SESSION_TYPE" == "wayland" ]; then 
  echo $SHARE | wl-copy -p
fi

echo $SHARE

notify-send "Clip copied to the clipboard"
