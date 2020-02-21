#!/bin/bash

mkdir kenangan
mkdir duplicate

for i in {1..28};
do
	#DIR=/home/whitezhadow

	FILE=pdkt_kusuma_$i.jpg
	LOGFILE=wget.log
	URL=https://loremflickr.com/320/240/cat

	#cd $DIR
	wget $URL -O $FILE -o $LOGFILE

	cat wget.log >> wgetpanjang.log
done
grep "Location" wgetpanjang.log >> location.log


readarray -t arr < location.log
cntr=0

for a in {0..27};
do
	nokenangan=$(ls -1 kenangan | wc -l)
	noduplicate=$(ls -1 duplicate | wc -l)
	cntr=$((0))
	echo ${arr[a]}, $nokenangan, $noduplicate
	echo pdkt_kusuma_"$((i+1))".jpg
	for((i=0; i<$a; i=i+1))
		do
		echo perbandingan["$(($a+1))"]dengan["$(($i+1))"]
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
		echo testcase1
	else
		echo testcase2
		mv pdkt_kusuma_"$(($a+1))".jpg duplicate/duplicate_"$(($noduplicate+1))".jpg
	fi

done

for nm in *.log; 
do 
	mv "$nm" "${nm%.log}.log.bak"
done 

 > wget.log
 > wgetpanjang.log
