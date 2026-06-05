---
title: Membangun Environment Laravel di Docker Compose
author: jouvanprb
description: >-
    Artikel ini membahas setup environment development Laravel berbasis Docker Compose. Stack yang digunakan mencakup Nginx sebagai web server, PHP 8.4-FPM sebagai application server, MySQL 8 sebagai database, dan phpMyAdmin untuk manajemen database via GUI. Semua layanan berjalan dalam container yang terisolasi dan terhubung melalui Docker network.
categories: [Containerization, Docker, Enviroment Setup]
tags: [docker, laravel, nginx, mysql, devops]
image : /posts/20260430/thumbnail-laravel-docker.png
render_with_liquid: false
---

Berikut adalah panduan setup environment Laravel di Docker menggunakan Nginx, PHP 8.4-FPM, MySQL 8, dan phpMyAdmin. Environment ini dirancang agar langsung bisa digunakan untuk development tanpa perlu konfigurasi manual.

## Langkah 1: Clone Repository
Clone repository yang sudah disiapkan:
![Desktop View](/posts/20260430/github-repo.png){: .light .w-auto .shadow .rounded-10 w='1212' h='668' }
![Desktop View](/posts/20260430/github-repo.png){: .dark .w-auto .shadow .rounded-10 w='1212' h='668' }


#### 1. Clone URL ini: <https://github.com/jouvanprb/laravel-docker>
#### 2. Masuk ke terminal dan buat suatu folder dengan perintah:
```bash
# nama direktori bisa disesuaikan
mkdir laravel-docker 
# masuk ke dalam direktori
cd laravel-docker
# clone repo (berikan tanda [.] di akhir untuk tidak membuat folder baru)
git clone https://github.com/jouvanprb/laravel-docker.git .
```
#### 3. Setelah mengikuti langkah di atas, masuk ke dalam teks editor:
```bash
# sesuaikan dengan teks editor yang digunakan
code .
```
Struktur folder akan tampak seperti ini:

```
├── docker
│   ├── nginx
│   │   └── nginx.conf
│   └── php
│       ├── Dockerfile
│       └── init.sh
├── docker-compose.yml
```

## Langkah 2: Konfigurasi
Setelah berhasil meng-clone repo, selanjutnya cek masing-masing file.

#### **File docker-compose.yml**
File ini mendefinisikan 4 service yang saling terhubung dalam satu network `laravel`:
- **app** — PHP-FPM untuk menjalankan Laravel. Build dari `docker/php/Dockerfile`. Source code di-mount dari folder `laravel_app`.
- **nginx** — Web server Alpine. Konfigurasi dari `docker/nginx/nginx.conf`. Meneruskan request PHP ke service `app`.
- **mysql** — Database MySQL. Data disimpan di volume `mysql_data` agar persisten.
- **phpmyadmin** — GUI database.

Jika ingin mengubah konfigurasi dari `container_name` laravel-docker, pastikan sama dengan isian pada mysql.
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

# Pastikan kedua konfigurasi ini memiliki isian sama. 
# Contoh: DB_DATABASE dan MYSQL_DATABASE.

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

#### **File Dockerfile**
File ini digunakan untuk build image PHP-FPM kustom.
- `FROM php:8.4-fpm` — Menggunakan base image PHP 8.4 dengan FPM (FastCGI Process Manager).
- **Install dependencies** — Menginstall paket sistem (`zip`, `unzip`, `git`, `curl`, `libpng-dev`, `libonig-dev`, `libxml2-dev`) dan extension PHP yang dibutuhkan Laravel (`pdo_mysql`, `mbstring`, `exif`, `pcntl`, `bcmath`, `gd`).
- **Install Composer** — Menyalin Composer dari image `composer:latest` ke dalam container untuk mengelola dependency PHP.
- **Copy entrypoint** — Menyalin script `init.sh` ke dalam container dan memberinya izin eksekusi.
- `WORKDIR` — Set working directory ke `/var/www/html`, tempat source code Laravel disimpan.
- `ENTRYPOINT` + `CMD` — Menjalankan `init.sh` saat container start, lalu melanjutkan ke `php-fpm` sebagai proses utama agar container tetap berjalan.

#### **File init.sh**
Script inisialisasi otomatis yang dijalankan setiap container PHP-FPM start. Fungsinya:
- **Install Laravel 13** — Script akan otomatis menginstall Laravel 13.
- **Setup .env** — Menyesuaikan konfigurasi database dari environment variable Docker.
- **Permission** — Mengatur izin folder `storage` dan `cache`.
- **Composer install** — Menginstall dependency PHP.
- **Migrasi database** — Membuat tabel di MySQL.
- **Cache** — Optimasi untuk production, clear untuk development.
- **Jalankan PHP-FPM** — Menjaga container tetap berjalan.

## Langkah 3: Instalasi
Setelah selesai mengkonfigurasi masing-masing file, sekarang ke terminal jalankan:

#### Instalasi
```bash
docker compose up
```

Proses instalasi akan berjalan, tunggu hingga proses ini selesai. 
![docker compose up](/posts/20260430/docker-compose-up.png)

Lalu cek apakah container yang sudah di-up berjalan dengan baik, jalankan perintah ini di terminal:
```bash
docker ps -a
```

Setelah dijalankan, dapat dilihat container tadi berjalan dengan baik seperti gambar di bawah ini:
![docker compose up](/posts/20260430/container.png)

4 container yang terbentuk dan berjalan dengan status Up:

| Container Name            | Image                     | Port                               |
| ------------------------- | :-----------------------: | :--------------------------------: |
| laravel-docker            | laravel-docker-app        | 9000/tcp (internal)                |
| laravel-nginx             | nginx:alpine              | 0.0.0.0:8000→80                    |
| laravel_mysql             | mysql:8                   | 0.0.0.0:3307→3306 & 33060/tcp      |
| laravel_phpmyadmin        | phpmyadmin                | 0.0.0.0:8001→80                    |

Berikut penjelasan masing-masing container secara berurutan:
1. Container PHP 8.4-FPM yang menjalankan aplikasi Laravel. Tidak membuka port ke host, hanya berkomunikasi internal dengan Nginx melalui port 9000.
2. Web server Nginx yang menerima request dari browser di port 8000 dan meneruskannya ke container PHP-FPM.
3. Database MySQL 8. Port 3307 di host diteruskan ke port 3306 di dalam container. Port 33060 adalah MySQL X Protocol.
4. phpMyAdmin untuk mengelola database via browser. Akses di port 8001, terhubung otomatis ke container MySQL.

#### Mengakses Environment
Setelah semua container berjalan, kamu bisa mengakses masing-masing layanan:

**1. Aplikasi Laravel**
Buka browser dan kunjungi:
```text
http://localhost:8000
```

**2. phpMyAdmin (GUI Database)**
Untuk mengelola database dengan tampilan GUI, buka:
```text
http://localhost:8001
```
Username dan password sesuaikan dengan isian `compose.yaml`.

Bisa juga mengakses database melalui container via CLI:
```bash
# Dalam direktori laravel-docker
docker exec -it laravel_mysql bash
```

Lalu jalankan:
```bash
mysql -u laravel -p
```

Kemudian kamu akan diminta memasukkan password. Masukkan sesuai dengan isian di `compose.yaml`:
  ![Build source](/posts/20260430/mysql-container.png){: .light .border .normal w='375' h='140' }
  ![Build source](/posts/20260430/mysql-container.png){: .dark .normal w='375' h='140' }

## Pengembangan dengan Docker
![laravel app](/posts/20260430/laravel-app.png) 

Laravel berjalan di dalam container, sehingga perintah Artisan dan Composer dijalankan melalui `docker exec`.

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
