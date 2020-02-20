#!/bin/bash

if [[ $1 =~ ^[a-zA-Z]+$ ]]
   then
       pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
       if [ ! -e $1 ];
       then
	   echo $pass >> $1.txt
       fi
else 
    echo "error: ga oleh pake angka"
fi


