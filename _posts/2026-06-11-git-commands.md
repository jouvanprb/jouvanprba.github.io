---
title: "Commands pada Git"
author: jouvanprb
categories: [Version Control, Git]
description: >-
    Kumpulan perintah Git esensial untuk mengelola versi kode, mulai dari
    staging, branching, remote, hingga kolaborasi via email patch.
tags: [git, github, version control, command line]
render_with_liquid: false
---

## Ringkasan Perintah Git

| Perintah | Deskripsi | Contoh Kode |
|---|---|---|
| `git add` | Memindahkan perubahan dari working directory ke staging area | `git add sample.md` |
| `git add .` | Men-staging semua file yang berubah di direktori saat ini dan subdirektori | `git add .` |
| `git am` | Menerapkan patch yang dikirim via email ke repositori | `git am <patchfile.patch` |
| `git branch` | Membuat lingkungan terisolasi di dalam repositori untuk membuat perubahan | `git branch <new-branch>` |
| `git checkout` | Melihat dan berpindah ke branch yang sudah ada | `git checkout <existing-branch>` |
| `git checkout main` | Berpindah ke branch main | `git checkout main` |
| `git clone` | Membuat salinan dari repositori remote | `git clone <repository-url>` |
| `git commit` | Mengambil snapshot staged dan menyimpannya ke proyek | `git commit -m "Your commit message here"` |
| `git config --global user.email` | Mengatur konfigurasi email global untuk Git | `git config --global user.email "your.email@example.com"` |
| `git config --global user.name` | Mengatur konfigurasi username global untuk Git | `git config --global user.name "Your Name"` |
| `git daemon` | Mengizinkan download anonim dari repositori | `git daemon --reuseaddr --verbose` |
| `git diff` | Membantu mereview kode dengan mengidentifikasi dan membandingkan perubahan | `git diff example.txt` |
| `git fetch` | Mengunduh perubahan dari repositori remote tanpa menggabungkannya | `git fetch origin main` |
| `git fetch upstream/main` | Mengambil branch upstream | `git fetch upstream main:upstream-main` |
| `git format-patch` | Membuat atau menyiapkan kiriman email untuk alur kerja forum publik ala kernel Linux | `git format-patch -n <number_of_commits>` |
| `git init` | Membuat repositori Git lokal baru di direktori yang ditentukan | `git init <directory>` |
| `git instaweb` | Menyiapkan front-end web untuk repositori Git | `git instaweb -p 8080` |
| `git log` | Menelusuri perubahan sebelumnya pada proyek | `git log -p filename` |
| `git merge` | Menggabungkan perubahan dari branch lain ke branch aktif saat ini | `git merge feature_branch` |
| `git merge upstream/main` | Menggabungkan perubahan dari branch upstream/main ke branch saat ini | `git merge upstream/main` |
| `git pull` | Mentransfer perubahan dari repo remote ke repo lokal dan menggabungkannya ke branch | `git pull origin main` |
| `git pull downstream` | Menarik perubahan dari repositori downstream, khususnya dari branch main | `git pull downstream main` |
| `git pull upstream` | Menarik perubahan dari repositori upstream ke branch saat ini | `git pull upstream main` |
| `git push` | Mendorong semua perubahan yang sudah di-commit ke repositori remote | `git push origin your_branch_name` |
| `git remote` | Mengelola kumpulan repositori yang dilacak | `git remote add upstream https://github.com/original/repo.git` |
| `git remote add origin <URL>` | Menambahkan repositori remote bernama origin dengan URL tertentu | `git remote add origin https://github.com/yourusername/your-repo.git` |
| `git remote add upstream` | Menambahkan repositori asli sebagai remote baru berlabel upstream | `git remote add upstream https://github.com/original/repo.git` |
| `git remote rename` | Mengganti nama repositori remote | `git remote rename origin new-origin` |
| `git remote -v` | Melihat remote yang terkait dengan repositori lokal | `git remote -v` |
| `git request-pull` | Membuat ringkasan perubahan untuk upstream melakukan pull | `git request-pull origin/main your-branch` |
| `git rerere` | Menggunakan kembali rekaman resolusi konflik merge yang pernah diselesaikan | `git rerere` |
| `git reset` | Membatalkan perubahan yang dibuat pada file di working directory | `git reset HEAD~1` |
| `git revert` | Membatalkan commit yang gagal | `git revert HEAD` |
| `git send-email` | Mengirim file patch sebagai email tanpa korupsi oleh MUA | `git send-email --to=recipient@example.com path/to/patchfile.patch` |
| `git send-email` | Mengirim kumpulan patch sebagai email | `git send-email --to recipient@example.com patches/*.patch` |
| `git-shell` | Login shell terbatas untuk pengguna repositori pusat bersama | `sudo usermod -s /usr/bin/git-shell gituser` |
| `git status` | Melihat keadaan working directory dan snapshot staged dari perubahan | `git status` |
| `git --version` | Menampilkan versi Git yang terinstal di sistem | `git --version` |

## Kesimpulan
Git adalah alat version control yang sangat berguna dalam proyek pengembangan apa pun. Dengan memahami perintah-perintah di atas beserta contoh kodenya, Anda bisa mengelola kode sendiri maupun berkolaborasi dalam tim secara efisien. Mulai dari inisialisasi repo, staging, commit, branching, hingga sinkronisasi dengan remote dan fork upstream.
