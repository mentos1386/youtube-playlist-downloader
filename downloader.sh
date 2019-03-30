#!/bin/bash
set -o pipefail

# Prameters
PLAYLIST_ID=$1
TYPE=$2

# Constants
DATA_DIR=${DATA_DIR}
PROGRESS_DATA_DIR="$DIR/progress"

# Verify that type is provided
if [[ $TYPE != 'video' && $TYPE != 'audio' ]]; then
	echo "Invalid type! Should be 'video' or 'audio'"
	exit 1
fi

if [ ! -d $PROGRESS_DATA_DIR ]; then
	mkdir -p "$PROGRESS_DATA_DIR"
fi

# Download video
if [ $TYPE = 'video' ]; then
	youtube-dl \
	-o "$DATA_DIR/%(playlist)s/%(playlist_index)s-%(title)s/%(title)s.%(ext)s" \
	-i \
	--write-description \
	--write-info-json \
	--write-thumbnail \
	--write-sub \
	--embed-thumbnail \
	--embed-subs \
	--prefer-free-formats \
	--download-archive "$PROGRESS_DATA_DIR/progress-$PLAYLIST_ID.txt" \
	"http://www.youtube.com/playlist?list=$PLAYLIST_ID"
fi

# Download audio
if [ $TYPE = 'audio' ]; then
	youtube-dl \
	-o "$DATA_DIR/%(playlist)s/%(playlist_index)s %(title)s.%(ext)s" \
	-i \
	--extract-audio \
	--embed-thumbnail \
	--audio-format mp3 \
	--download-archive "$PROGRESS_DATA_DIR/progress-$PLAYLIST_ID.txt" \
	"http://www.youtube.com/playlist?list=$PLAYLIST_ID"
fi

