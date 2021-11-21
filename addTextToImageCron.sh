#!/bin/bash

if pgrep -x "addWeather.sh"
then
    echo $(date) "Add Weather Is Running" >> /home/pi/addWeather.log
else
    echo $(date) "Add Weather Stopped -- Starting Up" >> /home/pi/addWeather.log
    /home/pi/addWeather.sh >> /home/pi/addWeather.log
fi
