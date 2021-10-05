SHOW databases; /* digunakan untuk menampilkan seluruh database*/

create database geeked; /* digunakan untuk membuat database baru*/
SHOW databases; /* periksa database yang kita buat */

drop database geeked; /* digunakan untuk menghapus database */
SHOW databases; /* periksa database yang kita hapus */

use world; /* digunakan untuk memilih database yang ingin digunakan */
show tables; /* digunakan untuk menampilkan table yang ada di dalam database */

select * from city;
select * from person; /* tanda * menandakan bahwa kita akan mengambil seluruh kolom dari table person */

select ID, Name, CountryCode, District, Population from city;
select PersonID, FirstName, city from person; /* mengambil kolom PersonID, FirstName, city dari table person */

create table geeked (
 MentorId int,
 Nama varchar(255),
 Alamat varchar(1000)
 ); /*	digunakan untuk membuat table bernama geeked dengan kolom
		MentorId bertipe int, Nama bertipe varchar dengan jumlah maksimal karakter 255,
        dan alamat bertipe varchar dengan jumlah maksimum karakter 1000 */
show tables;
select * from geeked;

drop table geeked; /* digunakan untuk menghapus table */

/* MENMBUAT TABLE DARI TABLE YANG SUDAH ADA */
create table geeked AS
select Name AS nama_kota, population
from city;
select * from geeked;


/* notes :
	SQL tidak case sensitive, jadi huruf besar atau kecil tidak berpengaruh.
	namun, saat memanggil kolom dalam table, nama kolom tidak berpengaruh
    terhadap pemanggilan (tidak akan eror), hanya saja nama kolom yang ada
    akan mengikuti pemanggilan kita (misal memanggil lastname
    dan LastName, data yang didapet bakal sama aja hanya saja nama kolom
    di tampilannya akan berbeda (menjadi lastname dan LastName) */


select distinct region from country;
/* digunakan untuk menghasilkan data yang unik (tidak ada yang duplikat) */

select * from city limit 6; /* digunakan untuk menampilkan 6 baris teratas */

select * from country;

select count(code) from country; /* digunakan untuk menghitung jumlah data pada kolom tertentu */

select avg(GNP) from country; /* digunakan untuk menghitung nilai rataan pada kolom tertentu */

select sum(population) from country; /* digunakan untuk menghitung total nilai pada kolom tertentu */

select code, min(GNP) as minimum_GNP from country where code = "IDN"; /* digunakan untuk menampilkan nilai minimum dari kolom GNP */

select code, max(GNP) as minimum_GNP from country where code = "IDN"; /* digunakan untuk menampilkan nilai maksimum dari kolom GNP */

/* notes :
1.	avg dan sum akan bernilai 0 jika data pada kolom bukan merupakan tipe data numerik */


/* memasukkan data kedalam table */
show tables;
select * from geeked;

insert into geeked (nama_kota) 
values ("geeked_city"); /* digunakan untuk memasukkan data ke dalam table */

select * from geeked where nama_kota = "geeked_city"; /* memeriksa apakah datanya sudah masuk atau belum */

/* input data tanpa menyebutkan nama kolom */
insert into geeked 
values ("bogor","1000000");
select * from geeked;
/*	pengisian data mengikuti urutan kolom */

/* Penggunaan operator WHERE */
select * from city where population > 1000000;
select * from city where district like "X%";

/*	where digunakan untuk memfilter data berdasarkan kondisi yang
	diinginkan oleh pengguna. pada contoh di atas, kondisi yang
    diberikan adalah kolom populasi pada table city bernilai lebih
    dari 1 juta dan kolom district pada table city diawali dengan huruf X */
/*	Like operator :
	1. "a%" -> mencari nilai yang diawali huruf a
    2. "%a" -> mencari nilai yang diakhiri huruf a
    3. "%a%" -> mencari nilai yang ada unsur huruf a diposisi apapun
    4. "_a%" -> mencari nilai yang huruf keduanya adalah a
    5. "a_%" -> mencari nilai yang huruf awalnya a dan panjang minimalnya 2 karakter
    6. "a__%" -> mencari nilai yang huruf awalnya a dan panjang minimalnya 3 karakter
    7. "a%o" -> mencari nilai yang diawali huruf a dan diakhiri huruf o*/
    
set SQL_SAFE_UPDATES = 0;
/* digunakan agar kita bisa melakukan update table. terkadang pengaturan workbench menyebabkan kita tidak bisa update table */
show tables;

select * from geeked;
update geeked
set nama_kota = "kota_geeked", population = "1000"
where nama_kota = "geeked_city";

select * from geeked where nama_kota = "kota_geeked";

/*	perintah update digunakan untuk mengubah isi data dengan value yang kita set.
	value harus diiringi dengan where untuk menunjukkan record/data mana yang ingin diubah. */

/* perintah delete */
select * from geeked;
insert into geeked
values ("kota uji coba", 15000);
insert into geeked
values ("kota uji coba 2", 10);
select * from geeked where nama_kota = "kota uji coba";

delete from geeked where nama_kota ="kota uji coba";
select * from geeked where nama_kota = "kota uji coba"; /* periksa pakah data sudah terhapus */
delete from geeked where population =10;
select * from geeked where nama_kota = "kota uji coba 2"; /* periksa pakah data sudah terhapus */

/* perintah between */
select * from geeked;
select nama_kota,population from geeked where population between 200000 and 700000;
select nama_kota,population from geeked where population not between 100000 and 900000;
/*	between digunakan untuk menunjukkan range data yang diinginkan.
	sedangkan not between berarti filter datanya selain range yang ditentukan*/

/* penggunaan order by untuk sorting data */
select * from geeked order by population; /* secara default ascending */
select * from geeked order by population asc; /* urutan secara ascending (dari kecil ke besar) */
select * from geeked order by population desc; /* urutan secara descending (dari besar ke kecil) */

/* 	order by digunakan untuk sort data secara ascending(default) dan descending.
	karena defaultnya asc maka tanpa menulis query asc pun, hasil order by akan asc. */

/* grouping data */
select * from country;
select Region, count(Name) as jumlah_data
from country
group by Region;

select countrycode, avg(Population) as populasi
from city
where countrycode = "IDN"
Group By district;

select avg(Population) as rata_rata, continent as benua
from country
where code = "IDN"
Group By Continent
having Rata_rata > 500000;

select avg(Population) as rata_rata, continent as benua
from country
where population > 100000
Group By Continent
having continent like "%america%";


/* note:
	group by jika tidak diiringi agregate function(count, min, max, sum, avg) akan menghilangkan data yang sama.
	misal data countrycode AFG pada table city kan ada yang punya id 1, 2, 3 4. nah kalau di group by
    maka data yang keliat bakal cuma AFG dengan id 1. ini contoh querynya
    select ID, CountryCode from city group by countrycode order by countrycode;*/

select * from country;
select name, round(GNP) as GNP
from country; /* digunakan untuk membulatkan nilai dari kolom lifeExpetancy */

select name, region, round(population/surfacearea,4) as population_density 
from country
where region = "caribbean"; /* digunakan untuk membulatkan nilai dari population/surfacearea dengan maksimal 4 digit desimal*/

select * from city;

/* SQL Scalar Function */
select name, length(name) as length_name
from city
where countrycode = "IDN"
order by length_name desc; /* digunakan untuk sortir berdasarkan panjang dari string */

select ucase(name), population
from city
where countrycode = "IDN"
order by population desc; /* digunakan untuk membuat uppercase pada setiap string */

select upper(name), population
from city
where countrycode = "IDN"
order by population desc; /* upper() juga digunakan untuk membuat uppercase pada setiap string */

select lcase(name), population
from city
where countrycode = "IDN"
order by population desc;

select lower(name), population
from city
where countrycode = "IDN"
order by population desc; /* lower() juga digunakan untuk membuat lowercase pada setiap string */

/*	Note:
1.	scalar function berbeda dengan agregate function. Scalar function itu mengedit nilai pada setiap/satu baris.
	contohnya kalau kita pake round(), maka nilai pada setiap baris akan dibulatkan.
    berbeda dengan agregate function yang perlu memperhatikan seluruh baris pada kolom tertentu.
    seperti fungsi avg() tentu fungsi ini akan mempertimbangkan data dari seluruh baris di kolom yang dipilih.
2.	scalar function akan mereturn value untuk setiap baris data. sedangkan agregat function akan mereturn satu value
	yang didapat dari keseluruhan data*/

/* Perbedaan group by dengan agregasi dan tanpa agregasi */
select * from country;
select continent, GNP
from country
group by continent
order by continent;

select continent, sum(GNP)
from country
group by continent
order by continent;

/*  group by tanpa agregasi akan menghasilkan value yang muncul pada kolom lain hanyalah value pertama saja
	bukan merupakan sum atau count dari data */

/* Sub Queries */

select name, surfaceArea
from country
where surfaceArea > (select avg(surfacearea) from country)
order by name;

/*	di atas merupakan contoh sub-queries, ini dibutuhkan karena where tidak
	bisa dibandingkan langsung dengan AVG (seperti query ini : where surfaceArea > AVG(surfaceArea)),
    jadi AVG harus pake sub-queries
    */


select name, surfaceArea, (select AVG(surfaceArea) from country) as mean_surfaceArea
from country
where region like "%america%"
order by name;
/* ini sub-queries yang digunain untuk membuat kolom yang berisi agregate function */


select * from country where code in (select countrycode from city);
select name, GNP
from country
where code
in (select countrycode from city group by countrycode having count(countrycode) > 5);

/* 	query diatas digunakan untuk menampilkan nama dan GNP dari tabel country dengan syarat
	code country pada table tersebut ada juga pada countrycode tabel city yang jumlah kotanya
    lebih dari 5 */

/* SQL Join Tables */
show tables;
select *,(select count(ID) from city) as jumlah_data from city;
select *, (select count(code) from country) as jumlah_data from country;
select *, (select count(code) from city, country) as jumlah_data from city, country;
/* 	dinamakan implicit join atau self join.
	gunanya menampilkan seluruh kolom pada table city dan country. 
    jumlah baris yang dihasilkan merupakan perkalian dari jumlah baris kedua table */


select *, (select count(code) from city, country where city.population = country.population) as jumlah_data from city, country
where city.population = country.population;
/*	menampilkan seluruh kolom pada kedua table dengan
	filter hanya population yang sama pada kedua table (menandakan bahwa hanya ada satu data kota pada suatu negara) */

select *, (select count(code) from city K, country N where K.population = N.population) as jumlah_data from city K, country N
where K.population = N.population;

/* sama kaya sebelumnya cuman lebih singkat karena menggunakan alias*/

select country.name as negara, country.population, city.name as kota, city.population, (select count(city.name) from country join city on country.population = city.population) as jumlah_data
from country join city
on country.population = city.population;

select N.name as negara, N.population, K.name as kota, K.population,
(select count(K.name) from country N join city K on N.population = K.population) as jumlah_data
from country N join city K
on N.population = K.population;

/* 	kedua table digabungkan dengan inner join berdasarkan population yang
	ada di kedua table */

select N.name as negara, N.population, K.name as kota, K.population,
(select count(N.population) from country N left join city K on N.population = K.population) as jumlah_data
from country N left join city K
on N.population = K.population;
/* 	kedua table digabungkan dengan left join berdasarkan kolom population yang
	ada di kedua table. hanya data yang ada di table 1 dan di kedua table
    yang akan ditampilkan. jika ada data population yang hanya ada di table 1
    maka data akan ditampilkan dengan catatan data pada kolom yang diminta
    pada table 2 akan bernilai null */

select N.name as negara, N.population, K.name as kota, K.population,
(select count(K.population) from country N right join city K on N.population = K.population) as jumlah_data
from country N right join city K
on N.population = K.population;

/* 	kedua table digabungkan dengan right join berdasarkan kolom population yang
	ada di kedua table. hanya data yang ada di table 1 dan di kedua table
    yang akan ditampilkan. jika ada data population yang hanya ada di table 2
    maka data akan ditampilkan dengan catatan data pada kolom yang diminta
    pada table 1 akan bernilai null */