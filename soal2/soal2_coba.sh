#!/bin/bash

jam=`date +"%H"`

lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper

namafile=$1
file="${namafile%.*}"

encrypt=`printf "$file" | tr [${lower:26}${upper:26}] [${lower:$jam:26}${upper:$jam:26}]`

mv $file.txt $encrypt.txt
