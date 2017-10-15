#!/bin/bash

# Prameters
PLAYLIST_ID=$1;
TYPE=$2;

# Constants
DIR=$(dirname -- "$0");
FOLDER="$HOME/Youtube";
PROGRAM_DATA="$DIR/progress"

# Verify that type is provided
if [[ $TYPE != 'video' && $TYPE != 'audio' ]]; then
	echo "Invalid type! Should be 'video' or 'audio'"
	exit 1
fi

if [ ! -d $PROGRAM_DATA ]; then
	mkdir -p "$PROGRAM_DATA"
fi


# Download video
if [ $TYPE = 'video' ]; then
	youtube-dl \
	-o "$FOLDER/%(playlist)s/%(playlist_index)s-%(title)s/%(title)s.%(ext)s" \
	-i \
	--write-description \
	--write-info-json \
	--write-thumbnail \
	--write-sub \
	--embed-thumbnail \
	--embed-subs \
	--prefer-free-formats \
	--download-archive "$PROGRAM_DATA/progress-$PLAYLIST_ID.txt" \
	"http://www.youtube.com/playlist?list=$PLAYLIST_ID"
fi

# Download audio
if [ $TYPE = 'audio' ]; then
	youtube-dl \
	-o "$FOLDER/%(playlist)s/%(playlist_index)s %(title)s.%(ext)s" \
	-i \
	--extract-audio \
	--embed-thumbnail \
	--audio-format mp3 \
	--download-archive "$PROGRAM_DATA/progress-$PLAYLIST_ID.txt" \
	"http://www.youtube.com/playlist?list=$PLAYLIST_ID"
fi


