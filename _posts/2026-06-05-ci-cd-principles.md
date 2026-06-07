---
title: "Mengenal Continuous Integration & Continuous Deployment"
author: jouvanprb
categories: [Continuous Integration / Continuous Deployment, Principles of CI/CD]
description: >-
    Mempelajari prinsip CI/CD dari pengertian, proses, keuntungan, perbedaan Delivery vs Deployment, dan tools yang umum dipakai.
tags: [CI/CD pipeline, DevOps]
image: /posts/20260605/thumbnail-ci-cd-principles.png
render_with_liquid: false
pin: true
---

**CI/CD** adalah singkatan dari **Continuous Integration** dan **Continuous Delivery atau Continuous Deployment**. Praktik ini menghubungkan tim development dengan tim operations lewat otomatisasi.

Intinya: setiap perubahan kode dari developer bisa langsung masuk ke proses **build, testing, dan rilis** secara otomatis. Tanpa CI/CD, semua proses itu dikerjakan manual dan rawan kesalahan.

Dulu tim developer bisa menghabiskan waktu berminggu-minggu hanya untuk menggabungkan kode. Sekarang dengan CI/CD, proses itu bisa selesai dalam hitungan menit setelah kode di-commit.

---

## Tiga Tahapan dalam CI/CD

CI/CD sebenarnya terdiri dari **tiga proses** yang berjalan bertahap. Masing-masing punya fungsi berbeda.

### 1. Continuous Integration (CI)
Di tahap ini, developer secara rutin menggabungkan kode mereka ke repositori utama. Idealnya **beberapa kali sehari**, bukan menunggu sampai semua fitur selesai.

Begitu kode masuk, sistem otomatis akan:
- Melakukan **build**
- Menjalankan **unit test** dan **integration test**
- Memberi tahu developer kalau ada yang gagal

Tujuannya: **masalah cepat ketemu** sebelum makin besar dan susah diperbaiki.

### 2. Continuous Delivery

Setelah CI berhasil, kode otomatis dikirim ke environment testing seperti **staging**. Di sini kode bisa dicek lagi sebelum benar-benar rilis ke pengguna.

Yang perlu dicatat: proses deployment ke production di tahap ini **masih butuh persetujuan manual**. Tim bisa menentukan kapan waktu yang tepat untuk rilis.

### 3. Continuous Deployment

Ini level paling tinggi. Begitu kode lolos semua tes, **langsung dikirim ke production** tanpa perlu approval.

Praktik ini cocok kalau tim sudah sangat percaya dengan kualitas automated testing. Kalau belum, lebih baik tetap di Continuous Delivery dulu.

---

## Delivery vs Deployment: Apa perbedaanya?

Banyak yang mengira dua istilah ini sama. Padahal sangat berbeda:

- **Continuous Delivery:** rilis ke production masih pakai tombol atau approval manual.
- **Continuous Deployment:** rilis ke production otomatis penuh.

Mana yang lebih baik? **Tergantung kebutuhan.** Aplikasi perbankan mungkin lebih cocok pakai Delivery karena ada kepatuhan dan regulasi. Startup SaaS biasanya lebih berani pakai Deployment penuh.

## Keuntungan Pakai CI/CD

Kenapa banyak tim mulai pakai CI/CD? Ini beberapa manfaat yang paling terasa:

1. **Feedback cepat.** Begitu commit, dalam beberapa menit sudah tahu hasilnya. Kalau ada yang rusak, langsung bisa diperbaiki.
2. **Bug ketahuan lebih awal.** Testing dijalankan setiap kali ada perubahan. Ini jauh lebih murah dibandingkan menemukan bug setelah semua fitur selesai.
3. **Developer bisa fokus coding.** Proses build, test, dan deploy sudah otomatis. Tidak perlu lagi menjalankan perintah manual berulang-ulang.
4. **Semua orang bisa lihat status proyek.** Pipeline CI/CD biasanya punya dashboard. Tim developer, QA, sampai manajer bisa tahu kondisi terbaru tanpa harus bertanya.
5. **Rilis lebih sering dan lebih cepat.** Fitur kecil bisa langsung sampai ke pengguna dalam waktu singkat, tidak perlu nunggu siklus rilis bulanan.


## Tools CI/CD yang Banyak Dipakai

Ada banyak pilihan. Berikut beberapa yang populer:

- **GitHub Actions:** Sudah terintegrasi dengan GitHub, konfigurasi pakai YAML.
- **GitLab CI/CD:** Satu platform lengkap dari kode sampai deployment.
- **Jenkins:** Open source, paling fleksibel, banyak plugin.
- **CircleCI:** Ringan dan cepat, cocok buat tim kecil.
- **ArgoCD:** Fokus ke deployment di Kubernetes dengan konsep GitOps.

> **Tips:** Pilih yang paling sesuai dengan tempat kode kamu sekarang. Kalau sudah pakai GitHub, GitHub Actions adalah pilihan paling praktis.

## Hal yang Sering Terlupakan

### Testing 
CI/CD mempercepat pengiriman kode. Kalau tidak ada testing, berarti kamu cuma mempercepat pengiriman bug. Sediakan unit test dan integration test. Jalankan otomatis tiap ada perubahan.

### Pipeline Simpan di Repositori
Simpan file konfigurasi pipeline di repositori kode, format YAML. Dengan begitu pipeline bisa direview, dicatat riwayat perubahannya, dan dikelola seperti kode lainnya.

### Siapkan Rollback
Deployment gagal bisa terjadi kapan saja. Pastikan pipeline punya cara untuk balik ke versi sebelumnya dengan cepat. Jangan tunggu kejadian dulu baru mencari cara.

## Penutup
CI/CD bukan cuma soal tools. Ini soal **cara kerja yang lebih terstruktur, otomatis, dan bisa diandalkan**.
Saya sendiri dulu mulai dari Jenkins manual yang ribet. Lama-lama pindah ke GitHub Actions karena lebih ringan. Setiap tools punya kelebihan masing-masing, jadi sesuaikan saja dengan kebutuhan.
Mulai dari **Continuous Integration** dulu, lalu bertahap ke **Delivery**, baru kemudian **Deployment** kalau sudah siap.