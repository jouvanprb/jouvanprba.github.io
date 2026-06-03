---
title: Fondasi Cloud 101 - Mengenal Komputasi Cloud
author: jouvanprb
categories: [Cloud Computing, Cloud Essentials]
description: >-
    Blog ini bertujuan untuk memahami dasar-dasar komputasi cloud berdasarkan referensi AWS. Mencakup definisi, manfaat, model layanan, hingga strategi deployment.
tags: [cloud-fundamentals, AWS]
image: /posts/20260601/thumbnail-cloud-101.png
render_with_liquid: false
pin : true
---

## Mengapa Beralih ke Komputasi Cloud?

1. **Infrastruktur sebagai Kode** – Sumber daya TI dapat dikonfigurasi dan dikelola secara terprogram, layaknya perangkat lunak.
2. **Akses yang Dinamis dan Fleksibel** – Kemampuan menyesuaikan kapasitas sumber daya secara real-time sesuai kebutuhan pengguna.
3. **Model Pembayaran Sesuai Pemakaian** – Memungkinkan eksperimen dan pengujian sistem tanpa perlu berkomitmen penuh di awal.

## Apa Itu Komputasi Cloud?

Komputasi cloud adalah model penyediaan sumber daya teknologi informasi sesuai permintaan melalui internet, dengan struktur biaya berdasarkan konsumsi aktual. Cakupan sumber dayanya meliputi server, jaringan, alat pengembangan, hingga aplikasi siap pakai.

## Perjalanan Singkat Komputasi Cloud

- **1961** – Ilmuwan komputer John McCarthy mencetuskan gagasan bahwa suatu hari komputasi akan dijual layaknya layanan utilitas publik.
- **1969** – Departemen Pertahanan Amerika Serikat menginisiasi ARPANET menggunakan protokol TCP/IP.
- **1985** – Lebih dari 100.000 komputer telah saling terhubung dalam jaringan internet.
- **1991** – World Wide Web (WWW) resmi diperkenalkan ke publik.
- **1997** – Istilah "cloud" dalam konteks komputasi pertama kali digunakan oleh Profesor Ramnath Chellappa dari Emory University dalam publikasi akademisnya.
- **2002** – Amazon Web Services (AWS) merilis layanan cloud publik perdananya.
- **2006** – AWS meluncurkan Amazon Elastic Compute Cloud (Amazon EC2) untuk khalayak umum.
- **2008** – Bermunculan berbagai penyedia layanan cloud berskala besar.
- **2015** – International Organization for Standardization (ISO) menerbitkan standar resmi pertama untuk komputasi cloud.

## Model Klien-Server
```
                    ┌──────────┐         Permintaan (Request)         ┌────────────┐
                    │          │ ──────────────────────────────────>  │            │
                    │  KLIEN   │                                      │   SERVER   │
                    │          │ <──────────────────────────────────  │            │
                    └──────────┘         Tanggapan (Response)         └────────────┘
                        ▲                                                   │
                        │                                                   │
                    Contoh:                                           Contoh:
                    • Browser web                                    • Amazon EC2
                    • Aplikasi desktop                               • Server virtual
                    • Perangkat mobile                               • Database server
```

**Alur Komunikasi:**
- **Klien** mengirimkan permintaan ke server—misalnya saat kamu mengetik alamat situs di browser.
- **Server** memproses permintaan tersebut dan mengirimkan kembali tanggapan—seperti halaman web yang muncul di layar.

Hubungan ini bersifat **timbal balik** *(request-response cycle)*, di mana klien selalu memulai interaksi dan server menyediakan layanan yang diminta.

## Manfaat Komputasi Cloud

Berikut enam keunggulan utama yang ditawarkan komputasi cloud:

| No | Manfaat             | Penjelasan Singkat                                                                 |
|----|---------------------|------------------------------------------------------------------------------------|
| 1  | **Biaya Awal Rendah**   | Tanpa investasi perangkat keras di muka, cukup bayar sesuai pemakaian.             |
| 2  | **Skalabilitas Tinggi** | Sumber daya dapat diperbesar atau diperkecil secara instan mengikuti fluktuasi kebutuhan. |
| 3  | **Akses Global**        | Layanan dapat diakses dari mana saja selama terhubung internet.                    |
| 4  | **Keandalan**           | Penyedia cloud menjamin ketersediaan layanan tinggi dengan mekanisme pemulihan bencana bawaan. |
| 5  | **Keamanan**            | Dilengkapi enkripsi, kontrol akses ketat, dan kepatuhan terhadap standar industri. |
| 6  | **Kecepatan Inovasi**   | Pengembang dapat langsung membangun dan menguji ide tanpa menunggu pengadaan infrastruktur. |

## Mendeploy ke Cloud

Layanan cloud menawarkan berbagai tingkat kontrol, fleksibilitas, dan pengelolaan sesuai kebutuhan pengguna. Secara umum, model layanan cloud terbagi menjadi tiga kategori utama, sementara strategi deployment-nya mencakup tiga pendekatan berbeda. Setiap model dan strategi ini menerapkan konsep **tanggung jawab bersama** antara kamu sebagai pengguna dan penyedia layanan cloud.

### Model Layanan Cloud

#### 1. Infrastructure as a Service (IaaS)

IaaS menyediakan sumber daya infrastruktur TI dasar yang dapat dikonfigurasi sesuai kebutuhan. Kamu mendapatkan kontrol penuh atas sistem operasi, penyimpanan, dan aplikasi yang dijalankan, tanpa perlu mengelola perangkat keras fisik.

**Karakteristik:**

- Tingkat kontrol dan fleksibilitas tertinggi bagi pengguna
- Sumber daya dapat disesuaikan dan diskalakan secara dinamis
- Kamu bertanggung jawab atas manajemen sistem operasi, middleware, dan aplikasi

**Contoh layanan AWS:**

- **Amazon EC2** – Server virtual yang dapat dikonfigurasi sesuai spesifikasi
- **Amazon S3 (Simple Storage Service)** – Penyimpanan objek berskala besar
- **Amazon RDS (Relational Database Service)** – Layanan basis data relasional terkelola
- **Amazon Route 53** – Layanan DNS yang andal dan skalabel

#### 2. Platform as a Service (PaaS)

PaaS menyediakan platform siap pakai bagi pengembang untuk membangun, menguji, dan mendeploy aplikasi tanpa perlu mengelola infrastruktur di bawahnya. Fokus utama kamu cukup pada kode dan logika aplikasi.

**Karakteristik:**

- Mengurangi beban manajemen server dan sistem operasi
- Mempercepat siklus pengembangan dan deployment
- Penyedia cloud menangani provisioning, patching, dan skalabilitas platform

**Contoh layanan AWS:**

- **AWS Elastic Beanstalk** – Layanan orkestrasi yang memudahkan deployment dan penskalaan aplikasi web secara otomatis. Kamu cukup mengunggah kode, dan Elastic Beanstalk akan menangani detail seperti provisioning kapasitas, load balancing, auto-scaling, serta pemantauan kesehatan aplikasi.

#### 3. Software as a Service (SaaS)

SaaS adalah model layanan di mana aplikasi lengkap telah disediakan oleh penyedia cloud dan siap digunakan langsung oleh pengguna akhir melalui internet, biasanya lewat browser web.

**Karakteristik:**

- Tidak perlu instalasi, pemeliharaan, atau manajemen infrastruktur sama sekali
- Akses mudah dari berbagai perangkat dan lokasi
- Penyedia menangani seluruh aspek teknis termasuk keamanan dan pembaruan

**Contoh layanan:**

- Situs rapat video (contoh: Amazon Chime, Zoom)
- Situs email berbasis web (contoh: Gmail, Outlook Online)
- Situs berbagi file dan kolaborasi dokumen (contoh: Google Drive, Dropbox)
- Aplikasi perpesanan dan komunikasi tim

### Strategi Deployment Cloud

#### 1. Cloud

Seluruh infrastruktur dan aplikasi berjalan sepenuhnya di lingkungan cloud publik penyedia layanan.

**Karakteristik:**

- Tidak ada ketergantungan pada perangkat keras lokal
- Skalabilitas tinggi dan pembaruan otomatis
- Cocok untuk startup, aplikasi baru, atau beban kerja yang fluktuatif

#### 2. Hybrid

Menggabungkan lingkungan cloud dengan infrastruktur on-premise yang saling terintegrasi. Data dan aplikasi dapat berpindah antara kedua lingkungan tersebut.

**Karakteristik:**

- Fleksibilitas dalam menentukan penempatan beban kerja
- Memungkinkan pemanfaatan investasi infrastruktur yang sudah ada
- Cocok untuk organisasi dengan regulasi ketat atau sistem legacy

#### 3. On-Premise

Infrastruktur dikelola secara mandiri di pusat data milik sendiri. Meskipun menggunakan teknologi virtualisasi dan otomatisasi serupa cloud, seluruh kendali tetap berada di tangan internal organisasi.

**Karakteristik:**

- Kontrol penuh atas keamanan, konfigurasi, dan kepatuhan
- Cocok untuk industri dengan persyaratan regulasi yang sangat ketat
- Membutuhkan investasi awal dan tim operasional yang mumpuni

### Tanggung Jawab Bersama

Penting untuk dipahami bahwa dalam setiap model layanan dan strategi deployment, terdapat pembagian tanggung jawab yang jelas antara penyedia cloud dan pelanggan. Secara umum:

| Aspek | Tanggung Jawab Penyedia | Tanggung Jawab Pelanggan |
|-------|------------------------|--------------------------|
| Keamanan fisik pusat data | ✅ | — |
| Infrastruktur jaringan dan server | ✅ | — |
| Sistem operasi dan patching | ✅ (SaaS & PaaS) / Sebagian (IaaS) | Sebagian (IaaS) |
| Konfigurasi keamanan aplikasi | — | ✅ |
| Manajemen akses pengguna | — | ✅ |
| Data dan enkripsi sisi klien | — | ✅ |

Prinsipnya sederhana: **penyedia bertanggung jawab atas keamanan *di dalam* cloud, sedangkan pelanggan bertanggung jawab atas keamanan *apa yang ada di dalam* cloud-nya.**