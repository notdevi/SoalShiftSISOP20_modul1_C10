#!/bin/bash

mkdir kenangan
mkdir duplicate

for i in {1..28};
do
#DIR=/home/devi

FILE=pdkt_kusuma_$i.jpg
LOGFILE=wget.log
URL=https://loremflickr.com/320/240/cat

#cd $DIR
wget $URL -O $FILE -o $LOGFILE

cat wget.log >> wgetpanjang.log
grep "Location" wgetpanjang.log >> location.log

done
 > wget.log
 > wgetpanjang.log
