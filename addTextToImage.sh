#!/bin/bash

# install inotify first
# apt-get install inotify-tools

# set date 20211116
d=$(date +%Y%m%d)

# get the time
t=$(date +%H)

# if the hour is GT zero and Less then 10 set the target date to the previous day
if (($t >= 0)) && (($t <= 8))
then
        d=$(date --date="${d} -1 day" +%Y%m%d)
        echo $(date) "It is GTE 0 AND LTE 8. Set date to minus one day:" $d  >> /home/pi/addWeather.log
else
        echo $(date) "It is _NOT_ GTE 0 AND LTE 8. Using todays date" $d "time:" $t  >> /home/pi/addWeather.log
fi

TARGET=~/allsky/images/$d
PROCESSED=~/allsky/images/$d

mkdir -p $target
mkdir -p $processed

inotifywait -m -e create -e moved_to --format "%f" $TARGET | while read FILENAME
do

        echo "Detected " $FILENAME >> /home/pi/addWeather.log
		
		#go get the data from my weather station
        # sky quality
        #sq=$(curl http://10.11.0.201/sq)
        #echo $sq
        # temp
        #ba=$(curl http://10.11.0.201/ba)
        #echo $ba
        cc=$(curl http://10.11.0.201/cc)
        echo $(date) "Image found... adding Cloud Cover" $cc "%" >> /home/pi/addWeather.log
        convert $TARGET/$FILENAME -gravity north -pointsize 100 -fill white -annotate +0+200 "CC:${cc}%" -quality 90% -strip $PROCESSED/$FILENAME

done
