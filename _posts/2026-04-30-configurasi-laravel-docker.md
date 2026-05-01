---
title: Membangun enviroment Laravel di Docker Compose
author: jouvanprb
categories: [Containerization, Docker]
tags: [docker, laravel, nginx, mysql]
render_with_liquid: false
---

Berikut adalah panduan setup environment Laravel di Docker menggunakan Nginx, PHP 8.4-FPM, MySQL 8, dan phpMyAdmin. Environment ini dirancang agar langsung bisa digunakan untuk development tanpa perlu konfigurasi manual.

## Langkah 1: Clone Repository
Clone repository yang sudah disiapkan:
![Desktop View](/posts/20260430/github-repo.png){: .light .w-auto .shadow .rounded-10 w='1212' h='668' }
![Desktop View](/posts/20260430/github-repo.png){: .dark .w-auto .shadow .rounded-10 w='1212' h='668' }


#### 1. clone url ini: <https://github.com/jouvanprb/laravel-docker>
#### 2. Masuk terminal dan buat suatu folder dengan perintah 
```bash
# nama direktori bisa disesuaikan
mkdir laravel-docker 
# masuk kedalam direktori
cd laravel-docker
# clone repo (berikan tanda [.] diakhir untuk tidak membuat suatu folder baru)
git clone https://github.com/jouvanprb/laravel-docker.git .
```
#### 3. Setelah mengikuti langkah diatas, masuk kedalam teks editor
```bash
# sesuaikan dengan teks editor yang digunakan
code .
```
Struktur folder akan tampak seperti ini

   ![Build source](/posts/20260430/struktur-folder.png){: .light .border .normal w='375' h='140' }
   ![Build source](/posts/20260430/struktur-folder.png){: .dark .normal w='375' h='140' }


## Langkah 2: Configurasi
Setelah berhasil meng-clone repo, selanjutnya cek masing-masing file 

#### **file docker-compose.yml**
File ini mendefinisikan 4 service yang saling terhubung dalam satu network laravel:
- app — PHP-FPM untuk menjalankan Laravel. Build dari docker/php/Dockerfile. Source code di-mount dari folder laravel_app.
- nginx — Web server Alpine. Konfigurasi dari docker/nginx/nginx.conf. Meneruskan request PHP ke service app.
- mysql — Database MySQL. Data disimpan di volume mysql_data agar persisten.
- phpmyadmin — GUI database.

Jika ingin mengubah configurasi dari pada container_name laravel-docker, pastikan sama dengan isian pada mysql.
```yml
app:
    build:
      context: .
      dockerfile: docker/php/Dockerfile
    container_name: laravel-docker
    volumes:
      - ./laravel_app:/var/www/html
    environment:
      DB_CONNECTION: mysql
      DB_HOST: mysql
      DB_DATABASE: laravel-db
      DB_USERNAME: laravel
      DB_PASSWORD: secret
    depends_on:
      - mysql
    networks:
      - laravel

# Pastikan kedua configurasi ini memiliki isian sama. 
# contoh: DB_DATABASE dan MYSQL_DATABASE.

mysql:
    image: mysql:8
    container_name: laravel_mysql
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: laravel-db
      MYSQL_USER: laravel
      MYSQL_PASSWORD: secret
    ports:
      - "3307:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - laravel
```

#### **file Dockerfile**
File ini digunakan untuk build image PHP-FPM kustom.
- FROM php:8.4-fpm — Menggunakan base image PHP 8.4 dengan FPM (FastCGI Process Manager).
- Install dependencies — Menginstall paket sistem (zip, unzip, git, curl, libpng-dev, libonig-dev, libxml2-dev) dan extension PHP yang dibutuhkan Laravel (pdo_mysql, mbstring, exif, pcntl, bcmath, gd).
- Install Composer — Menyalin Composer dari image composer:latest ke dalam container untuk mengelola dependency PHP.
- Copy entrypoint — Menyalin script init.sh ke dalam container dan memberinya izin eksekusi.
- WORKDIR — Set working directory ke /var/www/html, tempat source code Laravel disimpan.
- ENTRYPOINT + CMD — Menjalankan init.sh saat container start, lalu melanjutkan ke php-fpm sebagai proses utama agar container tetap berjalan.

#### **file init.sh**
Script inisialisasi otomatis yang dijalankan setiap container PHP-FPM start. Fungsinya:
- Install Laravel 13 — Script akan otomatis menginstall Laravel 13
- Setup .env — menyesuaikan konfigurasi database dari environment variable Docker
- Permission — mengatur izin folder storage dan cache
- Composer install — menginstall dependency PHP
- Migrasi database — membuat tabel di MySQL
- Cache — optimasi untuk production, clear untuk development
- Jalankan PHP-FPM — menjaga container tetap berjalan

## Langkah 3: Installasi
Setelah selesai meng-configurasi masing-masing file, sekarang ke terminal jalankan:

#### Installasi
```bash
docker compose up
```

Proses installasi akan berjalan, tunggu hingga proses ini selesai. 
![docker compose up](/posts/20260430/docker-compose-up.png)

Lalu cek apakah container yang sudah di up berjalan dengan baik jalankan perintah ini di terminal
```bash
docker ps -a
```

Setelah dijalankan dapat dilihat container tadi berjalan dengan baik seperti gambar di bawah ini  
![docker compose up](/posts/20260430/container.png)

4 container yang terbentuk dan berjalan dengan status Up:

| Container Name            | Image      |             Port                    |
| ------------------------- | :--------: | :---------------------------------: |
| laravel-docker  | laravel-docker-app   |      9000/tcp (internal)            |
| laravel-nginx   |    nginx:alpine       | 0.0.0.0:8000→80                     |
| laravel_mysql                 |     mysql:8       |     0.0.0.0:3307→3306 & 33060/tcp   |
|  laravel_phpmyadmin           |   phpmyadmin    | 0.0.0.0:8001→80                     |

Berikut Penjelasan masing-masing container secara berurutan:
1. Container PHP 8.4-FPM yang menjalankan aplikasi Laravel. Tidak membuka port ke host, hanya berkomunikasi internal dengan Nginx melalui port 9000.
2. Web server Nginx yang menerima request dari browser di port 8000 dan meneruskannya ke container PHP-FPM.
3. Database MySQL 8. Port 3307 di host diteruskan ke port 3306 di dalam container. Port 33060 adalah MySQL X Protocol.
4. phpMyAdmin untuk mengelola database via browser. Akses di port 8001, terhubung otomatis ke container MySQL.

#### Mengakses Enviroment
Setelah semua container berjalan, kamu bisa mengakses masing-masing layanan:

1. Aplikasi Laravel
Buka browser dan kunjungi:
```text
http://localhost:8000
```

2. phpMyAdmin (GUI Database)
Untuk mengelola database dengan tampilan GUI, buka:
```text
http://localhost:8001
```
username dan pw sesuaikan dengan isian compose.yaml

Bisa juga mengakses database melalui container via cli
```bash
# Dalam direktori laravel-docker
docker exec -it laravel_mysql bash
```

lalu jalankan 
```bash
mysql -u laravel -p
```

Kemudian kamu akan diminta memasukkan password. Masukkan sesuai dengan isian di compose.yaml
  ![Build source](/posts/20260430/mysql-container.png){: .light .border .normal w='375' h='140' }
   ![Build source](/posts/20260430/mysql-container.png){: .dark .normal w='375' h='140' }

## Pengembangan dengan Docker   
![laravel app](/posts/20260430/laravel-app.png) 

Laravel berjalan di dalam container, sehingga perintah Artisan dan Composer dijalankan melalui docker exec.

```bash
# Pastikan masuk ke dalam direktori App Laravel
cd laravel-app
```

#### Perintah Artisan
```bash
# Membuat Controller
docker exec -it laravel-docker php artisan make:controller NamaController

# Membuat Model
docker exec -it laravel-docker php artisan make:model NamaModel

# Membuat Model + Migration + Controller
docker exec -it laravel-docker php artisan make:model NamaModel -mcr

# Membuat Migration
docker exec -it laravel-docker php artisan make:migration create_nama_table

# Menjalankan Migration
docker exec -it laravel-docker php artisan migrate

# Menjalankan Seeder
docker exec -it laravel-docker php artisan db:seed

# Melihat daftar route
docker exec -it laravel-docker php artisan route:list

# Clear cache
docker exec -it laravel-docker php artisan optimize:clear
```

#### Perintah Composer
```bash
# Install package baru
docker exec -it laravel-docker composer require nama/package

# Update semua dependency
docker exec -it laravel-docker composer update

# Install dari composer.json
docker exec -it laravel-docker composer install
```

## Selesai
Dengan Docker Compose, environment Laravel siap digunakan tanpa instalasi manual. Semua berjalan dalam container yang terisolasi, portabel, dan konsisten di berbagai perangkat.

