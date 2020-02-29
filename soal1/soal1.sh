#!/bin/bash

echo "Region dengan profit paling sedikit :"

region=$(awk -F \\t 'FNR>1 { arr[$13] += $21 } END { for(b in arr) { print b } }' Sample-Superstore.tsv | sort -g | head -1)
echo $region 
echo $region > output_a
echo " "

echo "2 state dengan profit paling sedikit :"

state=$(awk -v region="$(cat output_a)" -F \\t 'FNR>1 { if ( $13 == region ) { arr[$11] += $21 } } END { for(b in arr) { print arr[b] "," b } }' Sample-Superstore.tsv | sort -g | head -2 | awk -F, '{ print $2 }')
echo $state
echo " "

state1=$(echo -e "$state" | sed -n '1p')
state2=$(echo -e "$state" | sed -n '2p')

echo "10 produk dengan profit paling kecil :"
product=$(awk -v state1="$state1" -v state2="$state2" -F \\t 'FNR>1 ($11~state1) || ($11~state2) {arr[$17]+=$21} END {for (i in arr) {printf "%s:%.2f\n", i, arr[i]}}' Sample-Superstore.tsv | sort -t $":" -nk2 | awk -F: '{print $1}' | head -10 )
echo $product
