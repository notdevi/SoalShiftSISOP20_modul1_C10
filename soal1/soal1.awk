#!/bin/bash

echo "Region dengan profit paling sedikit :"

region=$(awk -F \\t 'FNR>1
	 { if( $13 != "Region" ) { arr[$13] += $21 } }
	 END { for(b in arr) { printf b"\n" } }' Sample-Superstore.tsv | sort -g | head -1)

echo $region

echo "2 state dengan profit paling sedikit :"

state=$(awk -v region="$region" -F \\t 'FNR>1
	{ if ( $13 == region ) { arr[$11] += $21 } }
	END { for(b in arr) { printf b"\n" } }' Sample-Superstore.tsv | sort -g | head -2)

state1=$(echo -e "$state" | sed -n '1p')
state2=$(echo -e "$state" | sed -n '2p')

echo $state1
echo $state2

echo "10 produk dengan profit paling kecil :"
product=$(awk -v state1="$state1" -v state2="$state2" -F \\t 'FNR>1
	  { if ( $11 == state1 || $11 == state2) { arr[$17]+= $21 } }
	  END { for(b in arr) { printf b"\n" } }' Sample-Superstore.tsv | sort -g | head -10)

echo $product 
