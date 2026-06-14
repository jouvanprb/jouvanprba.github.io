---
title: "Dasar Linux: UNIX, Distribusi, dan Arsitektur"
author: jouvanprb
categories: [Linux]
description: >-
  fundamental Linux mencakup perbedaan Linux vs UNIX, distribusi
  linux, dan arsitektur kernel Linux.
tags: [linux, unix, operating system]
render_with_liquid: false
---

Linux adalah sistem operasi open-source berbasis kernel Linux, dilengkapi utilitas GNU. Sistem ini banyak digunakan di server, development, dan embedded system. Untuk memahami Linux secara utuh, ada tiga aspek fundamental yang perlu diketahui: hubungannya dengan UNIX, pilihan distribusi yang tersedia, dan arsitektur sistemnya.

Artikel ini membahas ketiga aspek tersebut secara ringkas dan terstruktur.

---

## Linux dan UNIX

Linux dan UNIX sering disamakan, padahal berbeda secara teknis maupun historis.

| Aspek | UNIX | Linux |
|-------|------|-------|
| **Asal** | Bell Labs (AT&T), 1969 | Linus Torvalds, 1991 |
| **Sumber Kode** | Closed-source | Open-source (GPL) |
| **Lisensi** | Komersial berbayar | Gratis, bebas dimodifikasi |
| **Contoh Sistem** | AIX, Solaris, HP-UX | Ubuntu, Debian, Fedora |
| **Standar** | Pencetus POSIX | Mengikuti standar POSIX |

**Poin utama:**
- Linux terinspirasi UNIX tapi ditulis dari nol tanpa kode proprietary
- Linux + utilitas GNU = sistem operasi lengkap (GNU/Linux)
- Mengikuti standar POSIX untuk kompatibilitas lintas sistem

---

## Distribusi Linux

Distribusi (distro) adalah paket bundel berisi kernel Linux, utilitas sistem, package manager, dan software tambahan. Satu kernel bisa dikemas dalam ratusan distro berbeda.

### Kategori Utama

| Keluarga | Package Manager | Format Paket | Contoh Distro |
|----------|----------------|--------------|---------------|
| **Debian** | APT | `.deb` | Ubuntu, Debian, Mint, Kali |
| **Red Hat** | DNF/YUM | `.rpm` | RHEL, Fedora, Rocky Linux |
| **Arch** | Pacman | `.pkg.tar.zst` | Arch Linux, Manjaro |
| **openSUSE** | Zypper | `.rpm` | openSUSE Leap, Tumbleweed |
| **Independen** | Portage | Source | Gentoo |

### Rekomendasi Berdasarkan Kebutuhan

| Kebutuhan | Distro |
|-----------|--------|
| Pemula / desktop | Ubuntu, Linux Mint |
| Server produksi | Debian Stable, Rocky Linux |
| Belajar dari dasar | Arch Linux, Gentoo |
| Keamanan / pentest | Kali Linux |
| PC spesifikasi rendah | Lubuntu, Puppy Linux |

---

## Arsitektur Linux

Sistem Linux tersusun dalam beberapa lapisan (layer) yang saling berinteraksi:


```
+-------------------------------------+
| UI (GUI / Terminal)                 |
+-------------------------------------+
| APPLICATION                         |
| - Shells                            |
| - User Apps                         |
| - System Daemons                    |
| - Linux Tools                       |
+-------------------------------------+
| OPERATING SYSTEM                    |
+-------------------------------------+
| KERNEL                              |
+-------------------------------------+
| HARDWARE                            |
+-------------------------------------+
```


### Penjelasan Tiap Lapisan

**Layer 1 — UI (GUI / Terminal)**
Antarmuka pengguna. Bisa berupa GUI (GNOME, KDE, XFCE) atau CLI lewat terminal.

**Layer 2 — Application**
Semua program yang berjalan di userspace:

| Komponen | Contoh | Fungsi |
|----------|--------|--------|
| **Shells** | bash, zsh, fish | Menerjemahkan perintah user ke sistem |
| **User Apps** | Browser, IDE, text editor | Aplikasi yang langsung dipakai user |
| **System Daemons** | systemd, sshd, cron | Proses background yang berjalan sejak boot |
| **Linux Tools** | ls, cp, grep, cat, chmod | GNU Coreutils dan tools dasar sistem |

**Layer 3 — Operating System**
Layer sistem operasi yang menjembatani aplikasi dengan kernel. Mengelola resource dan menyediakan layanan sistem ke aplikasi di atasnya.

**Layer 4 — Kernel**
Inti sistem operasi. Akses penuh ke hardware. Komponen utama:

| Subsystem | Fungsi |
|-----------|--------|
| **Process Scheduler** | Mengatur giliran proses di CPU, multitasking |
| **Memory Manager** | Virtual memory, paging, swapping |
| **VFS** (Virtual File System) | Abstraksi filesystem (ext4, XFS, NTFS) |
| **Network Stack** | TCP/IP, firewall (Netfilter/nftables) |
| **Device Drivers** | Komunikasi kernel dengan hardware (modul `.ko`) |

**Layer 5 — Hardware**
Perangkat fisik: CPU (x86_64, ARM, RISC-V), RAM, disk, NIC, GPU.

---

## Kesimpulan

- **Linux vs UNIX**: Linux open-source, patuh POSIX, tanpa kode UNIX proprietary.
- **Distribusi**: Pilih sesuai kebutuhan. Ubuntu untuk pemula, Rocky untuk server, Arch untuk belajar.
- **Arsitektur**: 5 layer (UI → Application → OS → Kernel → Hardware) menciptakan sistem modular, aman, dan fleksibel.

---

## Referensi

- [The Linux Kernel Documentation](https://docs.kernel.org/)
- [GNU Project](https://www.gnu.org/)
- [DistroWatch](https://distrowatch.com/)