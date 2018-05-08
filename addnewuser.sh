#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi


username="deanchao"

if id -u ${username}
then
        echo "user ${usrename} already exist, do not add"
else
        adduser --shell /bin/bash --disabled-password --gecos "" ${username}
fi

group="sudo"
if getent group ${group} | grep &>/dev/null "\b${username}\b"
then
    echo "user ${username} exists in ${group} group, do not add"
else
        usermod -aG ${group} ${username}
fi

sudoersfile="/etc/sudoers.d/90-cloud-init-users"
if grep --quiet ${username}  ${sudoersfile}
then
        echo "user ${username} exists in sudoers list"
else
        echo "${username} ALL=(ALL) NOPASSWD:ALL" >> ${sudoersfile}

fi
