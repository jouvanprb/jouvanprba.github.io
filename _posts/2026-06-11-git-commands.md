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

| Perintah | Deskripsi | Sintaks / Contoh |
|---|---|---|
| `git init` | Membuat repositori Git baru di direktori saat ini. | `git init` |
| `git clone` | Menyalin repositori dari remote ke lokal. | `git clone <URL>` |
| `git status` | Menampilkan status perubahan di working directory dan staging area. | `git status` |
| `git add` | Menambahkan perubahan ke staging area. | `git add .` (semua file), `git add <file>` (file tertentu) |
| `git commit` | Menyimpan perubahan yang sudah staged ke repositori dengan pesan. | `git commit -m "pesan"` |
| `git log` | Menampilkan riwayat commit. | `git log`, `git log --oneline -5` |
| `git diff` | Menampilkan perbedaan antar commit, branch, atau working directory. | `git diff`, `git diff main dev` |
| `git checkout` | Berpindah branch atau mengembalikan file ke versi sebelumnya. | `git checkout main`, `git checkout -- <file>` |
| `git switch` | Berpindah branch (alternatif modern dari checkout). | `git switch <branch>` |
| `git restore` | Mengembalikan file dari staging area atau commit tertentu. | `git restore <file>`, `git restore --staged <file>` |
| `git reset` | Mengatur ulang perubahan di working directory dan/atau staging area. | `git reset`, `git reset --hard HEAD` |
| `git revert` | Membatalkan commit dengan membuat commit baru yang isinya kebalikan. | `git revert HEAD` |
| `git branch` | Menampilkan, membuat, atau menghapus branch. | `git branch`, `git branch <nama>`, `git branch -d <nama>` |
| `git merge` | Menggabungkan branch lain ke branch aktif saat ini. | `git merge dev`, `git merge upstream/main` |
| `git pull` | Mengambil perubahan dari remote dan langsung menggabungkannya (fetch + merge). | `git pull origin main` |
| `git push` | Mengunggah commit lokal ke remote repository. | `git push origin main` |
| `git fetch` | Mengambil data terbaru dari remote tanpa langsung menggabungkannya. | `git fetch origin`, `git fetch upstream` |
| `git remote` | Menampilkan daftar remote repository. | `git remote` |
| `git remote -v` | Menampilkan daftar remote repository beserta URL-nya. | `git remote -v` |
| `git remote add origin <URL>` | Menambahkan remote repository bernama origin. | `git remote add origin <URL>` |
| `git remote add upstream <URL>` | Menambahkan remote repository bernama upstream (repo asli fork). | `git remote add upstream <URL>` |
| `git remote rename` | Mengganti nama remote repository. | `git remote rename origin upstream` |
| `git remote rm` | Menghapus remote repository. | `git remote rm origin` |
| `git pull upstream` | Mengambil perubahan dari upstream dan menggabungkan ke branch aktif. | `git pull upstream main` |
| `git merge upstream/main` | Menggabungkan branch main dari upstream ke branch aktif. | `git merge upstream/main` |
| `git format-patch` | Membuat file patch dari commit untuk dikirim via email. | `git format-patch HEAD~3` |
| `git request-pull` | Membuat ringkasan perubahan untuk permintaan pull via email. | `git request-pull origin/main <fork>` |
| `git send-email` | Mengirim file patch sebagai email. | `git send-email *.patch` |
| `git am` | Menerapkan file patch ke repositori. | `git am <file.patch>` |
| `git daemon` | Mengekspos repositori melalui protokol Git://. | `git daemon --base-path=/path` |
| `git instaweb` | Menjalankan server web instan untuk menjelajahi repositori. | `git instaweb --httpd=webrick` |
| `git rerere` | Menggunakan kembali rekaman resolusi konflik merge yang pernah diselesaikan. | `git rerere` (harus enable dulu) |
| `git --version` | Menampilkan versi Git yang terinstal. | `git --version` |
| `git config --global user.name` | Mengatur username global untuk Git. | `git config --global user.name "Nama"` |
| `git config --global user.email` | Mengatur email global untuk Git. | `git config --global user.email "email@contoh.com"` |
| `gh auth login` | Autentikasi akun GitHub di GitHub CLI. | `gh auth login` |

## Git init
**Deskripsi:** Membuat repositori Git baru di direktori saat ini. Perintah ini menginisialisasi folder biasa menjadi repositori Git dengan membuat folder `.git` tersembunyi.

**Sintaks:** `git init`

## Git clone
**Deskripsi:** Menyalin repositori dari sumber remote ke mesin lokal. Membuat salinan penuh repositori di direktori kerja saat ini.

**Sintaks:** `git clone <URL repositori>`

## Git status
**Deskripsi:** Menampilkan status perubahan di working directory dan staging area. Menunjukkan file mana yang sudah diubah, mana yang sudah staged, dan mana yang belum dilacak.

**Sintaks:** `git status`

## Git add
**Deskripsi:** Menambahkan perubahan ke staging area. Perintah ini mempersiapkan file yang diubah untuk commit berikutnya.

**Sintaks:**
- `git add <namafile>` (menambah file tertentu)
- `git add .` (menambah semua file baru atau berubah di direktori saat ini)
- `git add -A` (menambah semua perubahan di seluruh working tree)

## Git commit
**Deskripsi:** Menyimpan perubahan yang sudah staged ke repositori secara permanen dengan pesan yang menjelaskan perubahan.

**Sintaks:** `git commit -m "pesan commit"`

## Git log
**Deskripsi:** Menampilkan riwayat commit di repositori. Berguna untuk melihat siapa yang melakukan perubahan, kapan, dan apa pesannya.

**Sintaks:**
- `git log` (riwayat lengkap)
- `git log --oneline -5` (5 commit terakhir, ringkas)

## Git diff
**Deskripsi:** Menampilkan perbedaan antara commit, commit dengan working tree, atau membandingkan antar branch.

**Sintaks:**
- `git diff` (perbedaan working directory dengan commit terakhir)
- `git diff main dev` (membandingkan dua branch)
- `git diff main origin/main` (membandingkan lokal dengan remote)

## Git checkout
**Deskripsi:** Berpindah branch atau mengembalikan file ke versi commit sebelumnya.

**Sintaks:**
- `git checkout main` (pindah ke branch main)
- `git checkout -- <file>` (mengembalikan file ke versi terakhir)

## Git switch
**Deskripsi:** Berpindah antar branch atau membuat sekaligus pindah ke branch baru. Alternatif modern dari `git checkout`.

**Sintaks:** `git switch <nama-branch>`

## Git restore
**Deskripsi:** Membuang atau mengatur ulang perubahan pada file dengan mengembalikannya dari staging area atau commit tertentu.

**Sintaks:**
- `git restore <file>` (membuang perubahan di working directory)
- `git restore --staged <file>` (menghapus file dari staging area)
- `git restore --source <commit> <file>` (mengembalikan dari commit tertentu)

## Git reset
**Deskripsi:** Mengatur ulang perubahan di working directory. `git reset --hard HEAD` membuang semua perubahan yang belum di-commit secara permanen.

**Sintaks:**
- `git reset`
- `git reset --hard HEAD`

## Git revert
**Deskripsi:** Membatalkan commit dengan membuat commit baru. Commit baru ini berisi kebalikan dari perubahan commit yang ditentukan. Lebih aman daripada reset karena tidak menghapus riwayat.

**Sintaks:** `git revert HEAD`

## Git branch
**Deskripsi:** Menampilkan, membuat, atau menghapus branch di repositori.

**Sintaks:**
- `git branch` (menampilkan daftar branch)
- `git branch <nama-baru>` (membuat branch baru)
- `git branch -d <nama>` (menghapus branch)

## Git merge
**Deskripsi:** Menggabungkan branch lain ke branch yang sedang aktif. Semua commit dari branch sumber akan masuk ke branch target.

**Sintaks:** `git merge dev`, `git merge upstream/main`

## Git pull
**Deskripsi:** Mengambil perubahan dari remote repository dan langsung menggabungkannya ke branch lokal (fetch + merge otomatis).

**Sintaks:** `git pull origin main`

## Git push
**Deskripsi:** Mengunggah commit lokal ke remote repository. Pastikan berada di branch yang ingin di-push.

**Sintaks:** `git push origin <nama-branch>`

## Git fetch
**Deskripsi:** Mengambil data terbaru dari remote repository tanpa langsung menggabungkannya ke branch lokal. Aman untuk mengintip perubahan sebelum merge.

**Sintaks:**
- `git fetch origin` (ambil semua branch dari origin)
- `git fetch upstream` (ambil semua branch dari upstream)

## Git remote
**Deskripsi:** Menampilkan nama semua remote repository yang terhubung dengan repositori lokal.

**Sintaks:** `git remote`

## Git remote -v
**Deskripsi:** Menampilkan semua remote repository beserta URL-nya yang terhubung dengan repositori lokal.

**Sintaks:** `git remote -v`

## Git remote add origin <URL>
**Deskripsi:** Menambahkan remote repository bernama origin dengan URL tertentu. Origin biasanya menunjuk ke repositori milik sendiri di GitHub.

**Sintaks:** `git remote add origin <URL>`

## Git remote add upstream <URL>
**Deskripsi:** Menambahkan remote repository bernama upstream dengan URL tertentu. Upstream biasanya menunjuk ke repositori asli sumber fork.

**Sintaks:** `git remote add upstream <URL>`

## Git remote rename
**Deskripsi:** Mengganti nama remote repository. Diikuti nama lama dan nama baru.

**Sintaks:** `git remote rename origin upstream`

## Git remote rm
**Deskripsi:** Menghapus remote repository dengan nama yang ditentukan.

**Sintaks:** `git remote rm origin`

## Git pull upstream
**Deskripsi:** Mengambil perubahan dari remote upstream dan langsung menggabungkannya ke branch aktif.

**Sintaks:** `git pull upstream main`

## Git merge upstream/main
**Deskripsi:** Menggabungkan branch main dari remote upstream ke branch yang sedang aktif.

**Sintaks:** `git merge upstream/main`

## Git format-patch
**Deskripsi:** Membuat file patch dari commit untuk dikirim via email. Berguna untuk berbagi perubahan tanpa akses langsung ke repositori.

**Sintaks:** `git format-patch HEAD~3` (membuat patch untuk tiga commit terakhir)

## Git request-pull
**Deskripsi:** Membuat ringkasan perubahan yang tertunda untuk permintaan pull via email. Membantu mengkomunikasikan perubahan ke maintainer repositori upstream.

**Sintaks:** `git request-pull origin/main <fork atau nama-branch>`

## Git send-email
**Deskripsi:** Mengirim kumpulan file patch sebagai email. Pastikan sudah mengatur email dan nama dengan `git config`.

**Sintaks:** `git send-email *.patch`

## Git am
**Deskripsi:** Menerapkan file patch ke repositori. Mengambil file patch dan menerapkan perubahannya.

**Sintaks:** `git am <file.patch>`

## Git daemon
**Deskripsi:** Mengekspos repositori melalui protokol Git://. Protokol ringan untuk komunikasi efisien antara klien dan server Git.

**Sintaks:** `git daemon --base-path=/path/ke/repositori`

## Git instaweb
**Deskripsi:** Menjalankan server web instan untuk menjelajahi repositori. Menyediakan tampilan isi repositori via web tanpa konfigurasi server penuh.

**Sintaks:** `git instaweb --httpd=webrick`

## Git rerere
**Deskripsi:** Menggunakan kembali rekaman resolusi konflik merge yang pernah diselesaikan sebelumnya. Perlu mengaktifkan `rerere.enabled` menjadi `true`.

**Sintaks:**
- `git config --global rerere.enabled true`
- `git rerere`

## Git --version
**Deskripsi:** Menampilkan versi Git yang terinstal di sistem.

**Sintaks:** `git --version`

## Git config --global user.name
**Deskripsi:** Mengatur username global untuk Git. Nama ini akan muncul di setiap commit yang Anda buat.

**Sintaks:** `git config --global user.name "Nama Anda"`

## Git config --global user.email
**Deskripsi:** Mengatur email global untuk Git. Email ini harus cocok dengan email akun GitHub agar kontribusi terhitung.

**Sintaks:** `git config --global user.email "email@contoh.com"`

## gh auth login
**Deskripsi:** Mengautentikasi akun GitHub di GitHub CLI. Bisa login lewat browser atau token untuk mengakses fitur GitHub langsung dari terminal.

**Sintaks:** `gh auth login`

## Kesimpulan
Git adalah alat version control yang wajib dikuasai developer. Dengan memahami perintah-perintah di atas, Anda bisa mengelola kode sendiri maupun berkolaborasi dalam tim secara efisien. Mulai dari inisialisasi repo, staging, commit, branching, hingga sinkronisasi dengan remote dan fork upstream.