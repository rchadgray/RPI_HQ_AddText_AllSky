#!/bin/bash

# install inotify first
# apt-get install inotify-tools

# set date 20211116
d=$(date +%Y%m%d)

TARGET=~/allsky/images/$d
PROCESSED=~/allsky/images/$d

echo $TARGET

inotifywait -m -e create -e moved_to --format "%f" $TARGET | while read FILENAME
do
	echo Detected $FILENAME

	# sky quality
	sq=$(curl http://10.11.0.201/sq)
	echo $sq
	# temp
	ba=$(curl http://10.11.0.201/ba)
	echo $ba

	convert $TARGET/$FILENAME -gravity North -pointsize 100 -fill white -annotate +0+200 "TEMP:${ba} SQ:${sq}" $PROCESSED/$FILENAME

done
