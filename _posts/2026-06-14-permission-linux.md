---
title: "Memahami Permission Linux: chmod, rwx, dan Special Bits"
author: jouvanprb
categories: [Linux]
description: >-
  Panduan lengkap permission Linux: cara membaca rwx, menghitung
  numerik, perbedaan file vs folder, serta special permission
  seperti SetGID dan Sticky Bit.
tags: [linux, permission, chmod]
render_with_liquid: false
---

Setelah memahami dasar Linux, salah satu skill wajib berikutnya adalah **mengelola permission (izin akses)**. Permission menentukan siapa yang boleh membaca, menulis, atau mengeksekusi sebuah file/folder. Ini penting untuk keamanan sistem, terutama saat bekerja dengan server atau project kolaboratif.

Artikel ini merangkum semua yang perlu Anda tahu tentang permission Linux, dari dasar hingga special bits.

---

## Apa Itu Permission?

Setiap file dan folder di Linux memiliki **izin akses** (permission) yang mengatur siapa boleh melakukan apa. Ada 3 jenis pengguna (User, Group, Others) dan 3 jenis izin (Read, Write, Execute). Untuk memahaminya, mari kita telusuri lebih lanjut.

---

## 1. Melihat Permission dengan `ls -l`

Jalankan `ls -l` untuk melihat permission:

```bash
ls -l
# -rw-rw-r-- 1 crude crude 24 Jun 14 21:49 my_new_file
```

Struktur output-nya:

```Plaintext
-rw-rw-r--  1  crude  crude  24  Jun 14 21:49  my_new_file
──────────  ─  ─────  ─────  ──  ────────────  ───────────
    ①       ②    ③      ④     ⑤       ⑥             ⑦
```

| No | Nama | Penjelasan |
|---|---|---|
| 1 | Permission | 10 karakter: 1 tipe + 9 izin |
| 2 | Link count | Jumlah hard link |
| 3 | User (pemilik) | Yang punya file |
| 4 | Group | Grup pemilik file |
| 5 | Ukuran | Dalam byte |
| 6 | Tanggal & Waktu | Modifikasi terakhir |
| 7 | Nama | Nama file/folder |

---

## 2. Arti 10 Karakter Permission
10 karakter itu dibagi jadi 4 bagian:

```Plaintext
-   rwx   rwx   rwx
│   ───   ───   ───
│    ①     ②     ③
│
```

### Tipe (karakter ke-1)

| Simbol | Arti |
|:---|:---|
| `-` | File biasa |
| `d` | Folder (directory) |
| `l` | Link simbolik (shortcut) |

### Blok Izin (karakter ke-2 s/d 10)

Tiga blok masing-masing 3 karakter:

| Blok | Untuk | Posisi |
|:---|:---|:---|
| **User (u)** | Pemilik file | Karakter 2-4 |
| **Group (g)** | Anggota grup | Karakter 5-7 |
| **Others (o)** | Semua orang lain | Karakter 8-10 |

Setiap blok selalu berisi kombinasi:

| Simbol | Nama | Nilai Numerik |
|:---|:---|:---|
| `r` | **R**ead (baca) | 4 |
| `w` | **W**rite (tulis) | 2 |
| `x` | E**x**ecute (jalankan) | 1 |
| `-` | Tidak ada izin | 0 |

---

## 3. Baca Permission: File vs Folder

### File

| Izin | Arti |
|:---|:---|
| `r` | Bisa baca isi file (`cat`, `nano`) |
| `w` | Bisa edit/tulis file |
| `x` | Bisa menjalankan file sebagai program/script |

### Folder

| Izin | Arti |
|:---|:---|
| `r` | Bisa lihat daftar isi folder (`ls`) |
| `w` | Bisa buat/hapus file di dalam folder |
| `x` | Bisa masuk ke folder (`cd`) |

**Catatan penting:** Folder tanpa `x` tidak bisa dimasuki, meskipun punya `r`.

---

## 4. Mode Numerik (Angka)

Setiap blok dihitung dengan menjumlahkan nilai `r`=4, `w`=2, `x`=1:


```Plaintext
rwx  = 4+2+1 = 7
rw-  = 4+2+0 = 6
r-x  = 4+0+1 = 5
r--  = 4+0+0 = 4
-w-  = 0+2+0 = 2
--x  = 0+0+1 = 1
---  = 0+0+0 = 0
```


Hasilnya tiga digit: **[User][Group][Others]**

### Tabel Permission Paling Umum

| Numerik | Simbolik | Kapan Dipakai |
|:---|:---|:---|
| **777** | `rwxrwxrwx` | ❌ Sangat berbahaya, semua bisa segalanya |
| **755** | `rwxr-xr-x` | ✅ Standar untuk **folder** |
| **700** | `rwx------` | Folder privat, hanya pemilik |
| **644** | `rw-r--r--` | ✅ Standar untuk **file** |
| **664** | `rw-rw-r--` | File yang boleh diedit grup |
| **600** | `rw-------` | File rahasia (SSH key, `.env`) |
| **400** | `r--------` | Read-only untuk pemilik |

---

## 5. Perintah `chmod`

`chmod` = **Change Mode**, untuk mengubah permission.

### Mode Simbolik

```bash
chmod u+x script.sh      # User (pemilik) dapat execute
chmod go-w file.txt      # Group dan others tidak bisa tulis
chmod a=r file.txt       # Semua hanya bisa baca (444)
chmod +x script.sh       # Semua dapat execute (a+x)
chmod -w file.txt        # Semua tidak bisa tulis
```
### Mode Numerik

```bash
chmod 755 folder         # User=rwx, Group/Others=r-x
chmod 644 file.txt       # User=rw, Group/Others=r
chmod 600 id_rsa         # Hanya pemilik bisa baca & tulis
chmod 000 rahasia.txt    # Tidak ada yang bisa apa-apa
```

---

## 6. Special Permission
Ada tiga special bits yang kadang muncul:

### SetUID (`s` di posisi user)
```
-rwsr-xr-x
#  ^
#  s di blok user
```
File dijalankan sebagai pemilik file (bukan yang menjalankan). Contoh: /usr/bin/passwd

### SetGID (`s` di posisi group)
```
drwxr-sr-x
#     ^
#     s di blok group
```
Efek pada folder: Semua file/folder baru di dalamnya otomatis mewarisi grup folder induk.

```bash
chmod g+s folder_setgid    # Aktifkan SetGID
chmod g-s folder_setgid    # Matikan SetGID
# Numerik: tambah 2 di depan → 2755
```

### Sticky Bit (`t` di posisi others)
```
drwxrwxrwt
#        ^
#        t di blok others
```
Hanya pemilik file yang boleh menghapus file tersebut, meskipun folder writable oleh semua. Contoh: /tmp

```bash
chmod +t /shared         # Aktifkan sticky bit
chmod -t /shared         # Matikan
# Numerik: tambah 1 di depan → 1755
```

---

## 7. Perbedaan `s` vs `S` (Kecil vs Besar)

| Simbol | Execute (`x`) | SetGID | Bisa `cd`? |
|:---|:---|:---|:---|
| `rws` | ✔ Aktif | ✔ Aktif | ✔ Bisa |
| `rwS` | ✘ Mati | ✔ Aktif | ❌ Tidak |

`s` kecil = execute + SetGID dua-duanya aktif.  
`S` besar = SetGID aktif tapi execute mati (biasanya salah konfigurasi, jarang berguna).

---

## 8. Kepemilikan File (`chown`)
Selain permission, penting juga tahu siapa pemilik file:

```bash
ls -l
# -rw-r--r-- 1 crude crude ...
#             ^     ^
#          user   group
```

Mengubah kepemilikan (butuh `sudo`):

```bash
sudo chown user:group namafile
sudo chown budi:budi file.txt
sudo chown -R www-data:www-data /var/www/html   # Recursive
```

---

## 9. Ringkasan Cepat

| Kondisi | Pakai |
|:---|:---|
| Folder project | `chmod 755` |
| File biasa (.txt, .md, .php) | `chmod 644` |
| File rahasia (private key, .env) | `chmod 600` |
| Script/program | `chmod 755` atau `chmod +x` |
| Folder sharing tim | `chmod 2775` (SetGID) |
| Folder publik writable | `chmod 1777` (Sticky bit) |

---

## Penutup

Permission Linux adalah fondasi keamanan sistem. Dengan memahami `rwx`, mode numerik, dan special bits, Anda bisa mengontrol akses file/folder dengan tepat.