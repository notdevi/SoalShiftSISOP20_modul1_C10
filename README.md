# SoalShiftSISOP20_modul1_C10

### Nama Anggota Kelompok :
### 1. Devi Hainun Pasya (05111840000014)
### 2. Anggara Yuda Pratama (0511184000008)

### Soal No. 1
Terdapat data pada file "Sample-Superstore.tsv". Dari dara tersebut, tentukan :

(a) Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit. 

(b) Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a.

(c) Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b.

Penjelasan Script :

***soal1.awk***
```awk
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
```
(a) Langkah pertama yaitu agar awk dapat memilah text saat ditemukan koma `,` maka digunakan command `-F \\t` karena file data yang digunakan memiliki format .tsv yang berarti nilainya dipisahkan oleh Tab. Karena record number 1 merupakan header kolom, maka agar tidak ikut terhitung, perlu diberi kondisi mengunakan command `FNR>1` dan `if ( $13 == region )`.
Untuk mengakses kolom yang diperlukan, digunakan argumen yang bersesuaian dengan urutan ke berapakah kolom yang ingin diakses. Karena field region berada pada kolom ke-13, maka diakses sebagai argumen `$13`, sedangkan untuk kolom profit berada pada kolom ke-21, maka diakses sebagai argumen `$21`.  
Untuk mendapatkan total profit dari masing-masing region, digunakan array `arr` ber index `b` yang merupakan Region. Value dari array `arr` merupakan profit total dari hasil penjumlahan masing-masing Region. 
```awk
{ if( $13 != "Region" ) { arr[$13] += $21 } }
```
Setelah total profit dari masing-masing region didapatkan, untuk mencari region dengan profit paling rendah, digunakan command `pipe (|)` untuk mengurutkan profit dengan perintah `sort -g`. Lalu untuk mengambil data yang paling atas (profit paling rendah) digunakan perintah `head -1`.
```awk
{ for(b in arr) { printf b"\n" } }' Sample-Superstore.tsv | sort -g | head -1
```
(b) Seperti pada poin a, untuk mengakses kolom yang diperlukan digunakan argumen yang bersesuaian dengan urutan ke berapakah kolom yang ingin diakses. Karena field negara bagian (state) berada pada kolom ke-11, maka diakses sebagai argumen `$11`, kolom profit diakses sebagai argumen `$21`, dan kolom region diakses sebagai argumen `$13`.
Untuk mengakses output dari poin a, perlu mendeklarasi sebuah variable baru yaitu `$region` yang berisi output point a.
```awk
-v region="$region"
```
Sama dengan poin a, untuk mengelompokkan total profit dari masing-masing state, digunakan array `arr` ber index `b` yang merupakan State. value dari array `arr` merupakan profit total dari hasil pemjumlahan masing-masing State.
Karena yang diminta adalah profit state pada Region hasil poin a, maka diberi kondisi yaitu state yang di-cek hanya yang memiliki region dari hasil a.
```awk
{ if ( $13 == region ) { arr[$11] += $21 } }
```
Untuk mencari state 2 state dengan profit paling rendah, digunakan command `pipe (|)` untuk mengurutkan profit dengan perintah `sort -g`. Lalu diambil 2 data paling atas menggunakan perintah `head -2`.
```awk
{ for(b in arr) { printf b"\n" } }' Sample-Superstore.tsv | sort -g | head -2
```
Karena terdapat 2 hasil, untuk kepentingan soal poin 3, hasil output dipisah menjadi 2 variable dengan command `sed`.
```awk
state1=$(echo -e "$state" | sed -n '1p')
state2=$(echo -e "$state" | sed -n '2p')
```
(c) Sama seperti poin a dan b, digunakan argumen dan array untuk mendapatkan total profit dari masing-masing produk. Karena field produk (product) berada pada kolom ke-17, maka siakses sebagai argumen `$17`, kolom profit diakses sebagai argumen `$21`, dan kolom state diakses sebagai argumen `$11`.
Untuk mengakses output dari poin b, perlu mendeklarasi sebuah variable baru yaitu `$state1` dan `$state2` yang berisi output point a.
```awk
-v state1="$state1" -v state2="$state2"
```
Karena yang diminta adalah profit product pada State hasil poin b, maka diberi kondisi yaitu produk yang di-cek hanya yang memiliki state dari hasil b.
```awk
if ( $11 == state1 || $11 == state2)
```
Untuk mencari 10 produk dengan profit paling rendag, digunakan command `pipe (|)` untuk mengurutkan profit dengan perintah `sort -g`. Lalu diambil 10 data paling atas menggunakan perintah `head -10`.
```awk
 { for(b in arr) { printf b"\n" } }' Sample-Superstore.tsv | sort -g | head -10
```

### Soal No. 2
(a) Buatlah script bash yang dapat mengkasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.

(b) File password tersebut disimpan pada file berekstensi `.txt` dengan nama berdasarkan argumen yang diinputkan dan **hanya berupa alphabet**.

(c) File tersebut akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam (0-23) dibuatnya file tersebut dengan program terpisah.

(d) Buat juga dekripsinya.

Penjelasan Script : 

***soal2.sh***
```bash
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
```bash
pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
```
Password random akan di-generate oleh file `urandom`, dengan constraint password terdiri atas huruf kecil `a-z`, huruf besar `A-Z` dan angka `0-9` sebanyak 28 karakter, dan dibuat 1 buah setiap kali perintah dijalankan. String password tersebut disimpan dalam variable `$pass`.
(b) Kemudian isi dari variable tersebut dimasukkan ke dalam file berekstensi `.txt` dengan nama yang diinputkan sebagai `$1`.
Untuk mengantisipasi penginputan nama file yang tidak sesuai (mengandung angka) maka digunakan kondisi `if` sebagai berikut :
```bash
if [[ $1 =~ ^[a-zA-Z]+$ ]]
```
Argumen akan di cek apakah mengandung angka atau tidak, jika tidak maka random password akan di generate, apabila terdapat angka maka akan keluar pesan `error` dan random password tidak akan dibuat.
```bash
echo "error: ga oleh pake angka"
```
***soal2_coba.sh***
```bash
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
```bash
jam=`date +"%H"`
```
Kemudian dibuat variable string huruf untuk menampung setiap karakter dan mengubah ke karakter baru.
```bash
lower=abcdefghijklmnopqrstuvwxyz
lower=$lower$lower
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
upper=$upper$upper
```
Input yang berupa nama file yang akan di enkripsi di store ke dalam variable `$namafile`, kemudian string dari nama file (tanpa ekstensi) diambil dan di store ke variable `$file`.
```bash
namafile=$1
file="${namafile%.*}"
```
Karena huruf yang di enkripsi menjadi huruf lain memiliki selisih tertentu dalam urutan alphabet, maka teknik yang digunakan yaitu **Caesar Cipher**. Dengan key yaitu waktu jam dari variable `$jam`.
Untuk mengenkripsi, digunakan command `tr` untuk mentransformasi (menukar) huruf dari variable `$file` satu-persatu. Lalu di print dan disimpan dalam variable `$encrypt`.
```bash
encrypt=`printf "$file" | tr [${lower:26}${upper:26}] [${lower:$jam:26}${upper:$jam:26}]`
```
Kemudian untuk mengubah nama file password awal menjadi string yang sudah di enkripsi, digunakan command `mv` untuk me-rename file menjadi string yang di enkripsi.
```bash
mv $file.txt $encrypt.txt
```
***soal2_wadaw.sh***
```bash
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
```bash
decrypt=`printf "$file" | tr [${lower:$jam:26}${upper:$jam:26}] [${lower:26}${upper:26}]`
```

### Soal No.3
(a) Buat script untuk mendownload 28 gambar dari “https://loremflickr.com/320/240/cat” menggunakan command `wget` dan menyimpan file dengan nama `“pdkt_kusuma_NO”` dan simpan log messages wget kedalam sebuah file `“wget.log”`.

(b) Setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari sabtu.

(c) Buat script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila identik pindahkan salah satu gambar ke dalam folder `./duplicate` dengan format filename `duplicate_nomor`, dan sisanya di folder `./kenangan` dengan format filename `kenangan_nomor`. Lakukan back up seluruh  log menjadi ekstensi `.log.bak`.

***soal3.sh***
```bash
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
 ```
 (a) Untuk mendownload 28 gambar, digunakan loop `for i in {1..28};`.
Lalu masing masing komponen dari proses download gambar didefinisikan dalam variabel-variabel. Format penamaan gambar diberi variable `FILE`, file untuk menyimpan log messages wget diberi variable `FILELOG`, dan URL diberi variable `URL`.
```bash
FILE=pdkt_kusuma_$i.jpg
LOGFILE=wget.log
URL=https://loremflickr.com/320/240/cat
```
Kemudian gambar didownload dengan command `wget`
```bash
wget $URL -O $FILE -o $LOGFILE
```
Untuk proses comparing nantinya, isi dari `wget.log` di-*append* ke file bernama `wgetpanjang.log`, lalu diambil locationnya dan di-*append* ke file bernama `location.log`.
```bash
cat wget.log >> wgetpanjang.log
grep "Location" wgetpanjang.log >> location.log
```
Setelah proses looping download gambar selesai, file `wget.log` dan `wgetpanjang.log` dikosongkan untuk loop-loop berikutnya jika program dijalankan lagi.
```bash
 > wget.log
 > wgetpanjang.log
```
(b) Crontab untuk penjadwalan tersebut adalah :
```crontab
5 6-23/8 * * 0-5 ls -lt /home/devi/ && bash soal3.sh
```
(c) 
