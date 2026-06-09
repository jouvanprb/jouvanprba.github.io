---
title: "Mengenal Git & GitHub: Panduan Lengkap Version Control"
author: jouvanprb
categories: [Version Control, Git]
description: >-
    Panduan lengkap memahami Git dan GitHub dari dasar. Mencakup pengertian, konsep
    DVCS, branching strategy, hingga perintah-perintah esensial untuk kolaborasi tim.
tags: [git, github, version control, DevOps]
render_with_liquid: false
---
## Mengenal Git & GitHub

### Apa itu Git?

**Git** adalah sistem kontrol versi terdistribusi (*Distributed Version Control System* / DVCS) yang diciptakan oleh **Linus Torvalds** pada tahun 2005. Git lahir dari kebutuhan mengelola kode sumber kernel Linux yang sangat besar dan dikerjakan oleh ribuan kontributor di seluruh dunia.

Git memungkinkan developer untuk:

- Melacak setiap perubahan pada kode secara detail
- Bekerja secara offline tanpa koneksi internet
- Berkolaborasi dengan banyak orang tanpa konflik berarti
- Kembali ke versi sebelumnya kapan saja jika terjadi kesalahan

### Apa itu GitHub?

**GitHub** adalah platform hosting berbasis web yang dibangun di atas Git. Didirikan pada tahun 2008 dan kini dimiliki oleh Microsoft, GitHub menyediakan:

- Antarmuka visual untuk mengelola repositori Git
- Alat kolaborasi seperti *Pull Request* dan *Code Review*
- *Issue tracking* untuk manajemen bug dan fitur
- *GitHub Actions* untuk otomatisasi CI/CD
- *GitHub Pages* untuk hosting website statis (termasuk Jekyll)

> **Intinya:** Git adalah *engine*-nya, GitHub adalah *tempat berkumpul dan berkolaborasi*-nya.


## Mengapa Git Disebut DVCS?

### Perbandingan: Centralized vs Distributed VCS

| Aspek | Centralized VCS (SVN) | Distributed VCS (Git) |
|---|---|---|
| **Penyimpanan riwayat** | Hanya di server pusat | Salinan penuh di setiap komputer |
| **Bekerja offline** | ❌ Tidak bisa commit | ✅ Bisa commit, branch, merge |
| **Kecepatan operasi** | Lambat (tergantung jaringan) | Cepat (lokal) |
| **Single point of failure** | ❌ Rawan kehilangan data | ✅ Data tersebar di banyak tempat |
| **Kolaborasi** | Terbatas pada server pusat | Fleksibel (peer-to-peer) |

### Keuntungan DVCS

1. **Bisa commit, branch, merge, dan melihat log tanpa koneksi internet** — produktivitas tidak terhambat saat offline
2. **Tidak ada *single point of failure*** — jika server GitHub mati, riwayat proyek tetap aman di laptop masing-masing developer
3. **Kolaborasi lebih fleksibel** — bisa push/pull langsung antar developer tanpa melalui server pusat
4. **Branching murah dan cepat** — mendorong eksperimen tanpa takut merusak kode utama


## Istilah Dasar Git & GitHub

| Istilah | Penjelasan Singkat |
|---|---|
| **SSH Protocol** | Metode login aman dan terenkripsi antar komputer. Di GitHub, SSH dipakai agar tidak perlu masukkan username/password setiap push atau pull. |
| **Repository (Repo)** | Folder proyek yang dilengkapi kontrol versi. Menyimpan seluruh file dan riwayat perubahan. Bisa **lokal** (komputer) atau **remote** (GitHub/GitLab). |
| **Fork** | Salinan repositori orang lain ke akun GitHub Anda. Aman untuk eksperimen tanpa mengganggu repositori asli. Ajukan Pull Request jika perubahan layak digabung. |
| **Pull Request (PR)** | Cara meminta maintainer meninjau dan menyetujui perubahan Anda sebelum digabungkan ke branch utama. Tempat diskusi dan code review terjadi. |
| **Working Directory** | Folder kerja aktif di komputer Anda. Tempat mengedit file proyek sebelum di-*stage* dan di-*commit*. |
| **Staging Area** | Area persiapan antara working directory dan repository. Pilih perubahan mana yang akan di-commit menggunakan `git add`. |
| **Commit** | *Snapshot* permanen keadaan proyek pada titik waktu tertentu. Memiliki ID hash unik, timestamp, dan pesan deskriptif. |
| **Branch** | Jalur pengembangan terpisah dari kode utama (`main`/`master`). Memungkinkan pengerjaan fitur atau perbaikan secara independen. |
| **Merge** | Proses menggabungkan perubahan dari satu branch ke branch lain. Biasanya dari branch fitur kembali ke `main`. |
| **Clone** | Menyalin repositori remote ke komputer lokal **beserta seluruh riwayat commit dan branch**. Berbeda dengan download ZIP biasa. |
| **Push** | Mengirim commit dari repositori lokal ke remote (GitHub). Perubahan langsung bisa diakses kolaborator lain. |
| **Pull** | Mengambil perubahan terbaru dari remote dan langsung menggabungkannya ke branch lokal. Kombinasi `git fetch` + `git merge`. |
| **Fetch** | Mengambil perubahan dari remote **tanpa** langsung menggabungkan. Aman untuk melihat update sebelum memutuskan merge. |
| **Remote** | Koneksi antara repositori lokal dan server (GitHub/GitLab). Saat clone, default-nya bernama `origin`. |