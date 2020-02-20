#!/bin/bash

jam=`date +"%H"`

lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper

namafile=$1
file="${namafile%.*}"

decrypt=`printf "$file" | tr [${lower:$jam:26}${upper:$jam:26}] [${lower:26}${upper:26}]`

mv $file.txt $decrypt.txt
