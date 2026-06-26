---
title: "Installasi Docker Windows menggunakan WSL2"
author: jouvanprb
categories: [Containerization, Docker]
description: >-
    Panduan installasi Docker Engine di Windows melalui WSL2 sebagai alternatif
    ringan pengganti Docker Desktop. Step-by-step dari awal hingga siap digunakan.
tags: [docker, windows, CI/CD pipeline, DevOps]
render_with_liquid: false
---

Docker adalah platform containerization yang memungkinkan Anda membangun, mengelola, dan menjalankan aplikasi dalam lingkungan terisolasi yang disebut container. Docker dapat diinstall di tiga sistem operasi utama: Linux, Windows, dan MacOS.

Untuk pengguna Windows, terdapat dua metode installasi:

| Metode | Karakteristik |
|--------|---------------|
| **Docker Desktop** | Aplikasi lengkap dengan GUI, mudah digunakan namun mengonsumsi resource cukup besar (~4GB RAM). Cocok untuk penggunaan umum. |
| **Docker Engine via WSL2** | Docker berjalan di atas Windows Subsystem for Linux 2 (WSL2). Lebih ringan (~500MB RAM), performa mendekati native Linux, tanpa overhead GUI. |

Artikel ini akan membahas metode kedua: **Installasi Docker Engine di WSL2**. Pendekatan ini ideal bagi developer yang menginginkan performa optimal dengan penggunaan resource minimal.

> **Windows Subsystem for Linux 2 (WSL2)** adalah fitur virtualisasi ringan bawaan Windows yang memungkinkan Anda menjalankan kernel Linux secara native tanpa memerlukan virtual machine terpisah.
{: .prompt-info }

![docker installation requirements](/posts/20260607/prasyarat-installasi-docker.webp)
_Prasyarat installasi Docker di Windows dengan WSL2_

## Prasyarat Cek WSL-2

#### Buka powershell (Run as Administrator)
```powershell
# Cek apakah WSL sudah terinstall
wsl --version
```

> Kalau belum terinstall, Install WSL-2
> ```powershell
> wsl --install -d Ubuntu
> ```
> Restart komputer setelah install
{: .prompt-warning }


##  step 1: Buka & Setup WSL2
```powershell
# Cara 1: Start Menu → ketik "Ubuntu" → ENTER
# Cara 2: Di PowerShell/CMD → wsl
Username: namaanda
Password: *****

# Update System
sudo apt update && sudo apt upgrade -y
```

## step 2: Install Docker Engine
#### 2.1 Uninstall versi lama
Jika anda sebelumnya sudah pernah menginstall docker, kita harus uninstal semua package installasi yang sebelumnya.
```powershell
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do 
  sudo apt remove -y $pkg
done
```

#### 2.2 Setup Repository Docker
```powershell
# Install prerequisites
sudo apt update
sudo apt install -y ca-certificates curl

# Tambahkan GPG key Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Tambahkan repository Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list
sudo apt update
```

#### 2.3 Install Docker Engine + Tools
```powershell
# Jalankan di Terminal WSL2 (Ubuntu)
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Step 3: Konfigurasi User Docker
>Fungsi: Agar bisa docker tanpa sudo command
{: .prompt-tip }
>```powershell
>sudo usermod -aG docker $USER
>newgrp docker
>```

## Step 4: Start Docker Service
>Fungsi: Menjalankan Docker daemon. WSL2 tidak auto-start.
{: .prompt-info }
> 
> ```bash
> sudo service docker status
> ```
> 
> Jika Docker tidak berjalan, mulai secara manual:
> 
> ```bash
> sudo service docker start
> ```

#### Auto-Start (Opsional)
```powershell
echo 'if ! service docker status > /dev/null 2>&1; then
    sudo service docker start > /dev/null 2>&1
fi' >> ~/.bashrc
source ~/.bashrc
```
> **Manfaat Auto-Start Docker:** Script di `~/.bashrc`{: .filepath} memastikan Docker otomatis menyala setiap buka terminal WSL2. Menghindari error "Cannot connect to Docker daemon" karena lupa `sudo service docker start`{: .filepath} manual.
{: .prompt-info }


## step 5: Verifikasi Installasi telah sukses
```powershell
# Verifikasi dengan menjalankan hello world
docker run hello-world
docker --version
docker compose version
docker ps -a
```

>Output sukses: 
>```
>Hello from Docker!
>This message shows that your installation appears to be working correctly.
>```
{: .prompt-tip }


## Troubleshooting

| Error | Solusi |
|-------|--------|
| `Cannot connect to Docker daemon` | `sudo service docker start` |
| `Permission denied` | `sudo usermod -aG docker $USER && newgrp docker` |
| Docker hilang setelah restart | Buka WSL2, lalu `sudo service docker start` |


## Kesimpulan

Anda telah berhasil menginstall Docker Engine di Windows melalui WSL2 tanpa Docker Desktop. Docker kini berjalan di lingkungan Linux (WSL2) dengan resource lebih ringan, performa optimal, dan tanpa lisensi tambahan.

**Poin penting:**
- Semua perintah Docker dijalankan di **terminal WSL2**
- Gunakan **auto-start** agar Docker tidak perlu di-start manual setiap kali
- File project di Windows diakses dari WSL2 via path `/mnt/c/Users/...`


## Referensi

- [Dokumentasi Resmi Docker: Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- [Microsoft Learn: Docker containers on WSL2](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-containers)
- [Docker Hub: Official Images](https://hub.docker.com/)