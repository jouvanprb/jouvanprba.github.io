---
title: Apa itu AWS?
author: jouvanprb
categories: [Cloud Computing, AWS Fundamentals]
description: >-
    Artikel ini bertujuan untuk memahami dasar-dasar komputasi cloud berdasarkan referensi AWS. Mencakup definisi, manfaat, model layanan, infrastruktur global, dan strategi menghadapi kegagalan.
tags: [cloud-fundamentals, AWS]
image: /posts/20260604/thumbnail-aws-fundamental.png
render_with_liquid: false
---

Amazon Web Services (AWS) adalah platform cloud yang menyediakan lebih dari 200 layanan, mencakup komputasi, penyimpanan, basis data, analitik, jaringan, alat pengembang, machine learning, Internet of Things, dan keamanan. Semua layanan ini tersedia tanpa perlu memiliki server fisik sendiri.

**Manfaat utama menggunakan AWS:**
- Akses sesuai permintaan ke lebih dari 200 layanan (on-demand).
- Model harga bayar sesuai penggunaan (pay-as-you-go), tanpa biaya di muka.
- Tidak ada komitmen jangka panjang, sehingga aman untuk bereksperimen dan mencoba hal baru.
- Tersedia berbagai alat modern dalam satu ekosistem.

**Sejarah singkat AWS**
- **2003:** Chris Pinkham dan Benjamin Black mengusulkan ide menjual infrastruktur internal Amazon sebagai layanan publik.
- **2004:** Simple Queue Service (SQS) diluncurkan sebagai layanan pertama.
- **2006:** AWS resmi menjadi platform komersial dengan peluncuran Amazon S3 dan EC2.
- **2010:** Seluruh situs retail Amazon.com bermigrasi ke AWS, membuktikan skalabilitas dan keandalannya.
- **2012:** Konferensi tahunan re:Invent dimulai, bersamaan dengan peluncuran sertifikasi profesional pertama.
- **2015-2017:** Pendapatan AWS tumbuh pesat hingga $27 miliar per tahun, didorong oleh ekspansi layanan AI dan Machine Learning.

Saat ini, jutaan pelanggan menggunakan AWS, dari startup hingga perusahaan besar seperti Netflix dan Airbnb.


## Infrastruktur Global AWS

AWS menjalankan infrastrukturnya di seluruh dunia melalui kombinasi **Region**, **Availability Zone (AZ)** , dan **Edge Location**.

- **Region:** Wilayah geografis yang berisi minimal dua Availability Zone.
- **Availability Zone:** Satu atau beberapa pusat data fisik yang terpisah dalam satu Region.
- **Edge Location:** Titik kehadiran untuk layanan caching dan pengiriman konten (CloudFront).

**Manfaat infrastruktur global:**
- Kinerja yang lebih cepat karena server dekat dengan pengguna.
- Ketersediaan tinggi karena beban kerja tersebar di beberapa lokasi.
- Keamanan data sesuai regulasi wilayah setempat.
- Keandalan dengan isolasi kegagalan antar-AZ.
- Skalabilitas untuk menambah kapasitas kapan saja.
- Biaya rendah karena hanya membayar yang digunakan.


## Perencanaan Menghadapi Kegagalan

**Penyimpanan (Storage)**
Data harus disimpan secara otomatis di beberapa perangkat keras sekaligus. Jika satu perangkat rusak, data tetap aman di perangkat lain. Selain itu, buat salinan data di Availability Zone atau Region yang berbeda. Jika satu lokasi mengalami gangguan, data masih bisa diakses dari lokasi lain.

**Komputasi (Compute)**
Jalankan minimal dua server aplikasi secara bersamaan di lokasi fisik yang berbeda. Jika satu server mati atau lokasinya bermasalah, beban kerja langsung dialihkan ke server lain yang masih aktif. Sistem juga perlu dikonfigurasi agar bisa menambah kapasitas server secara otomatis saat jumlah pengguna meningkat.

**Basis Data (Database)**
Siapkan server database cadangan yang selalu siaga dalam mode Multi-AZ. Jika server utama mengalami gangguan, proses peralihan ke server cadangan terjadi otomatis dalam hitungan detik. Aplikasi tetap berjalan tanpa perlu intervensi manual.


## Model Tanggung Jawab Bersama (Shared Responsibility Model)

Keamanan di AWS adalah tanggung jawab bersama antara AWS dan pelanggan.

- **AWS bertanggung jawab atas keamanan cloud:** Meliputi infrastruktur fisik, jaringan, dan layanan dasar.
- **Pelanggan bertanggung jawab atas keamanan di dalam cloud:** Meliputi konfigurasi sistem operasi, aplikasi, enkripsi data, firewall, dan manajemen akses pengguna.

Pembagian ini memastikan masing-masing pihak fokus pada area yang menjadi keahliannya.


## AWS Well-Architected Framework

AWS menyediakan kerangka kerja bernama Well-Architected Framework untuk membantu membangun sistem cloud yang optimal. Terdapat enam pilar utama:

1.  **Operational Excellence:** Menjalankan dan memantau sistem secara efektif.
2.  **Security:** Melindungi data, sistem, dan aset.
3.  **Reliability:** Memastikan sistem pulih dari kegagalan dan memenuhi permintaan.
4.  **Performance Efficiency:** Menggunakan sumber daya komputasi secara tepat.
5.  **Cost Optimization:** Menghindari biaya yang tidak perlu.
6.  **Sustainability:** Meminimalkan dampak lingkungan dari beban kerja cloud.

Mengabaikan salah satu pilar dapat menyebabkan sistem tidak sesuai dengan kebutuhan atau menimbulkan masalah di kemudian hari. AWS juga menyediakan alat gratis bernama **AWS Well-Architected Tool** untuk mengevaluasi beban kerja berdasarkan pilar-pilar ini dan memberikan rekomendasi perbaikan.


## AWS Global Accelerator

AWS memliki konsep yaitu **AWS Global Accelerator**. Layanan ini meningkatkan ketersediaan dan performa aplikasi global dengan mengarahkan lalu lintas pengguna melalui jaringan global AWS yang optimal.

Cara kerjanya: pengguna mengakses aplikasi melalui dua alamat IP statis yang disediakan Global Accelerator. Lalu lintas kemudian melewati jaringan backbone AWS, bukan internet publik biasa, menuju endpoint aplikasi terdekat yang sehat. Jika satu endpoint atau Region bermasalah, Global Accelerator secara otomatis mengalihkan lalu lintas dalam waktu kurang dari satu menit.

Ini berbeda dengan Route 53 yang bekerja di level DNS, karena Global Accelerator beroperasi langsung di level jaringan, memberikan failover yang jauh lebih cepat.

## Referensi

Catatan ini disusun dari beberapa sumber berikut:
- Dokumentasi resmi AWS: [https://docs.aws.amazon.com/](https://docs.aws.amazon.com/)
- AWS Well-Architected Framework: [https://docs.aws.amazon.com/wellarchitected/](https://docs.aws.amazon.com/wellarchitected/)
- AWS Global Infrastructure: [https://aws.amazon.com/about-aws/global-infrastructure/](https://aws.amazon.com/about-aws/global-infrastructure/)