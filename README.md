# SoalShiftSISOP20_modul1_C10

### Soal No. 1

### Soal No. 2
(a) Buatlah script bash yang dapat mengkasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.

(b) File password tersebut disimpan pada file berekstensi `.txt` dengan nama berdasarkan argumen yang diinputkan dan **hanya berupa alphabet**.

(c) File tersebut akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam (0-23) dibuatnya file tersebut dengan program terpisah.

(d) Buat juga dekripsinya.

Script : 

***soal2.sh***
```
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
```
(a) Script bash yang digunakan untuk menghasilkan password adalah :
```
pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
```
Password random akan di-generate oleh file `urandom`, dengan constraint password terdiri atas huruf kecil `a-z`, huruf besar `A-Z` dan angka `0-9` sebanyak 28 karakter, dan dibuat 1 buah setiap kali perintah dijalankan. String password tersebut disimpan dalam variable `$pass`.
(b) Kemudian isi dari variable tersebut dimasukkan ke dalam file berekstensi `.txt` dengan nama yang diinputkan sebagai `$1`.
Untuk mengantisipasi penginputan nama file yang tidak sesuai (mengandung angka) maka digunakan kondisi `if` sebagai berikut :
```
if [[ $1 =~ ^[a-zA-Z]+$ ]]
```
Argumen akan di cek apakah mengandung angka atau tidak, jika tidak maka random password akan di generate, apabila terdapat angka maka akan keluar pesan `error` dan random password tidak akan dibuat.
```
echo "error: ga oleh pake angka"
```
***soal2_coba.sh***
```
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
```
(c) Langkah pertama enkripsi yaitu mengambil jam `"%H"` dari waktu dan disimpan pada variable `$jam` yang nantinya akan digunakan untuk `key` dari proses enkripsi.
```
jam=`date +"%H"`
```
Kemudian dibuat variable string huruf untuk menampung setiap karakter dan mengubah ke karakter baru.
```
lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper
```
Input yang berupa nama file yang akan di enkripsi di store ke dalam variable `$namafile`, kemudian string dari nama file (tanpa ekstensi) diambil dan di store ke variable `$file`.
```
namafile=$1
file="${namafile%.*}"
```
Karena huruf yang di enkripsi menjadi huruf lain memiliki selisih tertentu dalam urutan alphabet, maka teknik yang digunakan yaitu **Caesar Cipher**. Dengan key yaitu waktu jam dari variable `$jam`.
Untuk mengenkripsi, digunakan command `tr` untuk mentransformasi (menukar) huruf dari variable `$file` satu-persatu. Lalu di print dan disimpan dalam variable `$encrypt`.
```
encrypt=`printf "$file" | tr [${lower:26}${upper:26}] [${lower:$jam:26}${upper:$jam:26}]`
```
Kemudian untuk mengubah nama file password awal menjadi string yang sudah di enkripsi, digunakan command `mv` untuk me-rename file menjadi string yang di enkripsi.
```
mv $file.txt $encrypt.txt
```
***soal2_wadaw.sh***
```
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
```
(d) Untuk melakukan dekripsi, kurang lebih sama dengan proses enkripsi, perbedaannya terdapat pada command `tr`. Untuk mentransformasi ke nama awal, string yang dibandingkan pada command `tr` ditukar posisinya sehingga menjadi :
```
decrypt=`printf "$file" | tr [${lower:$jam:26}${upper:$jam:26}] [${lower:26}${upper:26}]`
```

### Soal No.3
