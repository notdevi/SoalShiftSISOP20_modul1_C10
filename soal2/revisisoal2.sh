#!/bin/bash


if [[ $1 =~ ^[a-zA-Z]+$ ]]
   then
       pass="$(cat /dev/urandom | tr -dc 0-9 | head -c 1)"
       pass="$pass""$(cat /dev/urandom | tr -dc A-Z | head -c 1)"
       pass="$pass""$(cat /dev/urandom | tr -dc a-z | head -c 1)"
       pass="$pass""$(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 25)"
       if [ ! -e $1 ];
       then
	   echo $pass >> $1.txt
       fi
else 
    echo "error: ga oleh pake angka"
fi
