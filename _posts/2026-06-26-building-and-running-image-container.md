---
title: Membangun dan Menjalankan image Kontainer
author: jouvanprb
categories: Containerization, Docker
description: >- 
    Setelah membaca artikel ini, anda dapat memahami bagaimana membangun container image dengan menggunakan Dockerfile, 
    membuat container berjalan menggunakan image,
    menjelaskan perintah utama Docker
tags: [docker, DevOps]
---

Artikel ini merupakan lanjutan dari pembahasan sebelumnya mengenai instalasi Docker Engine pada windows menggunakan SSL [Instalasi Docker Engine](http://localhost:4001/posts/docker-installation/), bagi yang menggunakan sistem operasi seperti Linux atau MacOs dapat menginstall terlebih dahulu Docker Engine pada dokumentasi resmi Docker [Docker Docs](https://docs.docker.com/engine/install).

## Proses pembuatan container Docker
Step untuk membuat container Docker:
1. Menulis berkas Dockerfile yang berisi instruksi pembangunan image
2. Melakukan docker build untuk menghasilkan Docker Image
3. Menjalankan docker run untuk membuat Container dari image tersebut

![Docker process build container](/posts/20260626/docker-process.png)

## Dockerfile example
Contoh berkas Dockerfile ini memiliki perintah from dan CMD
```dockerfile
FROM alpine
CMD ["echo", "Hello World!"]
```
- From Instruksi untuk menentukan base image (image dasar)
- CMD Instruksi untuk menentukan perintah default saat container dijalankan 

## Docker Build Command
Membangun Docker Image dari Dockerfile.
```shell
docker build -t my-app:v1 .
```
Penjelasan sebagai berikut:
```plaintext
docker build -t my-app:v1 .
  │           │    │   |  │
  │           │    │   |  └ Current Directory
  |           |    |   └─── version
  │           │    └─────── Repository (nama image)
  │           └──────────── Tag 
  └──────────────────────── Command
```
Output sebagai berikut
```bash
Sending build context to Docker daemon  
-
-
Successfully built <image-id>
Successfully tagged my-app:v1
```

## Docker Image verification
Untuk meng-verifikasi pembuatan images, jalankan command ini
```shell
$ docker images
```
Output sebagai berikut
```bash
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
my-app       v1        789def456abc   2 minutes ago    7.05MB
alpine       latest    324bc02ae123   2 weeks ago      7.05MB
```

## Docker run command
Untuk menjalankan dan membuat container menggunkakan command
```shell
$ docker run my-app:v1
```
Dengan image container ini, app akan mencetak **Hello World!**

untuk meng-verifikasi container telah dibuat jalankan command ini
```shell
$ docker ps -a
```

## Perintah Dasar Docker

| Command | Tujuan | Contoh |
|---------|--------|--------|
| `docker build` | Membangun image dari Dockerfile | `docker build -t my-app:v1 .` |
| `docker images` | Melihat daftar image lokal | `docker images` |
| `docker run` | Menjalankan container dari image | `docker run -d --name web nginx` |
| `docker push` | Mengunggah image ke registry | `docker push username/my-app:v1` |
| `docker pull` | Mengunduh image dari registry | `docker pull nginx:latest` |

## Kesimpulan
Proses membangun dan menjalankan container Docker terdiri dari tiga langkah utama:
1. **Menulis Dockerfile** — Sebuah berkas teks yang berisi instruksi seperti `FROM` (menentukan base image) dan `CMD` (menentukan perintah default).
2. **Build Image** — Menggunakan perintah `docker build -t nama:tag .` untuk mengkompilasi Dockerfile menjadi Docker Image yang dapat digunakan.
3. **Run Container** — Menjalankan image menjadi container dengan perintah `docker run nama:tag`.