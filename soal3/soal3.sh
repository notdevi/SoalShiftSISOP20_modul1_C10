#!/bin/bash

if [[ `ls $PWD | grep "kenangan"` != "kenangan" ]]
then
  mkdir $PWD/kenangan
fi

if [[ `ls $PWD | grep "duplicate"` != "duplicate" ]]
then
  mkdir $PWD/duplicate
fi
for i in {1..28};
do
	#DIR=/home/whitezhadow

	FILE=pdkt_kusuma_$i.jpg
	LOGFILE=wget.log
	URL=https://loremflickr.com/320/240/cat

	#cd $DIR
	wget $URL -O $FILE -o $LOGFILE
done
grep "Location" wget.log >> location.log


readarray -t arr < location.log
cntr=0

for a in {0..27};
do
	nokenangan=$(ls -1 kenangan | wc -l)
	noduplicate=$(ls -1 duplicate | wc -l)
	cntr=$((0))
	for((i=0; i<$a; i=i+1))
		do
		if [ $a -eq 0 ]
			then mv pdkt_kusuma_1.jpg kenangan/kenangan_1.jpg

		elif [ "${arr[$a]}" == "${arr[$i]}" ]
			then
			cntr=$((1))
			break
		fi
	done

	if [ $cntr -eq 0 ]
	then
		mv pdkt_kusuma_"$(($a+1))".jpg kenangan/kenangan_"$(($nokenangan+1))".jpg
	else
		mv pdkt_kusuma_"$(($a+1))".jpg duplicate/duplicate_"$(($noduplicate+1))".jpg
	fi

done

for nm in *.log; 
do 
	mv "$nm" "${nm%.log}.log.bak"
done 

 > wget.log
