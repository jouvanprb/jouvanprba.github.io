---
title: Memahami Arsitektur Docker
author: jouvanprb
categories: [Containerization, Docker]
description: >- 
    Artikel ini membahas tentang arsitektur Docker, mulai dari client, host, 
    daemon, registry, hingga komponen yang dikelola seperti images, containers, 
    networks, dan storage.
tags: [docker, DevOps]
---

Docker adalah platform yang memungkinkan aplikasi dikemas bersama seluruh dependensinya ke dalam container, sehingga dapat berjalan konsisten di berbagai enviroment. Arsitektur Docker dirancang dengan pendekatan client-server, terdiri dari beberapa komponen yang saling berkomunikasi untuk menjalankan dan mengelola container. Memahami arsitektur ini penting agar Anda dapat menggunakan Docker secara efektif, baik untuk pengembangan maupun produksi. Artikel ini akan membahas setiap komponen utama, proses kerja, komunikasi antar komponen, dan cara akses registry.


## Proses dalam Docker

Berikut adalah alur sederhana bagaimana Docker bekerja dari awal hingga akhir:

1. **Client mengirim perintah**  
   Pengguna menggunakan **Docker CLI** (command line interface) atau **REST API** untuk mengirim instruksi ke server Docker (host).

2. **Host menerima perintah**  
   Server Docker yang disebut **host** berisi komponen utama bernama **Docker daemon** (`dockerd`).

3. **Daemon mendengarkan permintaan**  
   Docker daemon selalu mendengarkan permintaan dari API Docker, misalnya perintah seperti `docker run`. Setelah menerima, daemon langsung memprosesnya.

4. **Daemon menjalankan tugas**  
   Daemon bertugas untuk:
   - **Membangun** (*build*) image
   - **Menjalankan** (*run*) container
   - **Mendistribusikan** (*push*) image ke registry

5. **Registry menyimpan image**  
   Registry berfungsi sebagai tempat penyimpanan image Docker, seperti Docker Hub atau registry pribadi.


## Komponen yang Dikelola Host Docker 

![Docker host component](/posts/20260629/dockerdComponents.avif)

| Komponen | Penjelasan Singkat |
|----------|---------------------|
| **Images** | Template atau cetakan baca-saja yang digunakan untuk membuat container. Image berisi aplikasi, library, dan semua dependensi yang dibutuhkan agar aplikasi bisa berjalan. |
| **Namespaces** | Mekanisme isolasi di Linux yang membuat setiap container memiliki ruang sendiri (proses, jaringan, pengguna, hostname, dll). Ini memastikan container satu dengan lainnya tidak saling mengganggu. |
| **Storage** | Penyimpanan data untuk container. Meliputi volume (penyimpanan persisten yang tetap ada meski container dihapus) dan data sementara (layered filesystem) yang digunakan container selama berjalan. |
| **Containers** | Instansi aktif dari image. Container adalah lingkungan aplikasi yang berjalan dan terisolasi di dalam host. Satu image bisa menghasilkan banyak container. |
| **Networks** | Jaringan virtual yang menghubungkan container satu sama lain, dengan host, atau dengan dunia luar. Docker menyediakan driver network seperti bridge, host, overlay, dan macvlan. |
| **Plugins and Add-ons** | Ekstensi yang menambahkan fungsionalitas tambahan ke Docker, misalnya plugin untuk volume (seperti NFS, cloud storage), plugin untuk network, atau plugin untuk otentikasi. |


## Docker Communications

Docker memiliki fleksibilitas tinggi dalam hal komunikasi antar komponennya. Berikut adalah poin-poin penting tentang komunikasi di Docker:

### Komunikasi Client-Host

![Docker client-host](/posts/20260629/docker1.avif)

Docker client dapat berkomunikasi dengan host yang **lokal** (satu mesin) maupun **remote** (mesin berbeda). Ini memungkinkan pengguna untuk mengelola container dari mana saja, baik dari komputer sendiri maupun dari server jarak jauh.


### Komunikasi Client & Host berbeda sistem

![Docker client-host berbeda sistem](/posts/20260629/docker2.avif)

Docker client dan daemon host memiliki fleksibilitas dalam hal penempatan. Keduanya dapat berjalan pada **sistem yang sama** (misalnya di laptop development) atau pada **sistem yang berbeda** (misalnya client di laptop, host di server cloud). Fleksibilitas ini memberikan kemudahan dalam berbagai skenario penggunaan.


#### Contoh Perintah untuk Komunikasi Remote

```bash
# Menggunakan SSH
docker -H ssh://user@remote-server.com ps

# Menggunakan TCP (dengan TLS)
docker -H tcp://192.168.1.100:2376 --tlsverify ps

# Mengatur environment variable
export DOCKER_HOST=tcp://192.168.1.100:2375
docker ps
```

### Komunikasi Daemon-Daemon

![Docker client-host berbeda sistem](/posts/20260629/docker3.avif)

Docker daemon juga dapat berkomunikasi dengan daemon lain untuk mengelola layanan Docker dalam skala cluster. Contohnya pada **Docker Swarm**, beberapa daemon bekerja sama sebagai satu kesatuan untuk:
- Menjadwalkan container
- Menjaga ketersediaan layanan
- Sinkronisasi state antar node


## Registry Access

Registry adalah komponen penting dalam ekosistem Docker yang berfungsi sebagai **tempat penyimpanan image** (repository). Melalui registry, image dapat dibagikan dan didistribusikan ke berbagai enviroment.

![Docker Registry](/posts/20260629/registry.avif)


## Docker Architecture

Docker menggunakan arsitektur **client-server** yang terdiri dari beberapa komponen utama yang saling terhubung dan bekerja sama untuk menyediakan lingkungan aplikasi yang lengkap dan portabel.

![Docker Architecture](/posts/20260629/dockerArchitecture.avif)

### 1. Docker Client

**Docker Client** adalah antarmuka yang digunakan pengguna untuk berinteraksi dengan Docker.

**Fungsi:**
- Mengirim perintah ke Docker daemon
- Menerima output dari daemon
- Menyediakan antarmuka melalui CLI atau REST API

**Lokasi:**
- Dapat berjalan di sistem yang sama dengan host
- Dapat berjalan di sistem yang berbeda (remote)

**Contoh Perintah:**
```bash
docker run nginx
docker build -t my-app .
docker pull ubuntu:latest
```

### 2. Docker Host

**Docker Host** adalah server atau mesin tempat Docker daemon berjalan dan semua container dijalankan.

**Fungsi:**
- Menyediakan infrastruktur untuk menjalankan container
- Menyimpan dan mengelola images
- Mengelola jaringan dan storage untuk container

**Lokasi:**
- Dapat berupa mesin fisik, virtual, atau cloud instance
- Bisa di lokal (laptop/PC) atau di server remote

**Komponen di dalam Host:**
- **Docker Daemon** (dockerd) - otak yang menjalankan perintah
- **Images** - template aplikasi
- **Containers** - aplikasi yang berjalan
- **Networks** - jaringan antar container
- **Storage** - penyimpanan data container

**Peran Docker Host dalam Arsitektur:**

| Aspek | Penjelasan |
|-------|------------|
| **Tempat Container Berjalan** | Semua container dieksekusi di dalam host |
| **Manajemen Sumber Daya** | Mengalokasikan CPU, memory, dan storage untuk container |
| **Isolasi** | Menyediakan isolasi antar container melalui namespaces dan cgroups |
| **Konektivitas** | Mengelola jaringan agar container dapat berkomunikasi |

**Contoh Host:**

| Jenis Host | Contoh |
|------------|--------|
| **Lokal** | Laptop/PC dengan Docker Desktop |
| **Cloud** | AWS EC2, Google Compute Engine, Azure VM |
| **On-Premises** | Server fisik di data center |
| **Virtual** | Virtual Machine (VMware, VirtualBox) |


### 3. Docker Daemon (dockerd)

**Docker Daemon** adalah komponen inti yang bertanggung jawab menjalankan semua operasi Docker.

**Fungsi:**
- Menerima perintah dari Docker client
- Membangun, menjalankan, dan mengelola container
- Mengelola images
- Mengelola jaringan dan storage
- Berkomunikasi dengan registry

**Karakteristik:**
- Berjalan sebagai service di latar belakang (background service)
- Selalu aktif menunggu perintah
- Bertanggung jawab atas lifecycle container

**Lokasi:**
- Berjalan di dalam Docker Host
- Mengakses resources host (CPU, memory, storage)

**Contoh Tugas Daemon:**

| Perintah dari Client | Yang Dilakukan Daemon |
|----------------------|----------------------|
| `docker run nginx` | Membuat dan menjalankan container dari image nginx |
| `docker build -t my-app .` | Membangun image dari Dockerfile |
| `docker push my-app` | Mengirim image ke registry |
| `docker pull nginx` | Mengunduh image dari registry ke host |
| `docker stop container_id` | Menghentikan container yang sedang berjalan |
| `docker rm container_id` | Menghapus container |


## Referensi

- [Docker Documentation - Architecture](https://docs.docker.com/get-started/overview/)
- [Docker Docs - Docker Daemon](https://docs.docker.com/reference/cli/dockerd/)
- [Docker Docs - Docker Registry](https://docs.docker.com/registry/)
- [Docker Hub](https://hub.docker.com/)