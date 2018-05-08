#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get update && sudo apt-get upgrade

sudo apt-get install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal -y

sudo apt-get install vnc4server -y

#may need to run this portion interactively
vncserver -kill :1
vncserver :1

mv -v ~/.vnc/xstartup ~/.vnc/xstartup.$(date '+%Y-%m-%d-%H-%M-%S')
ln -s  ${DIR}/vnc/xstartup ~/.vnc/xstartup


line='@reboot /usr/bin/vncserver :7 -geometry 1600x900'

if [[ $(crontab -l | egrep -v "^(#|$)" | grep -q 'vncserver'; echo $?) == 1 ]]
then
    echo $(crontab -l ; echo ${line}) | crontab -
fi


