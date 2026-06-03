---
title: "Fungsi Ngrok dalam Development"
author: jouvanprb
categories: [Tunnel, Ngrok]
tags: [ngrok, development, localhost]
description: "Penjelasan tentang fungsi ngrok untuk membuka akses localhost ke internet, mencakup webhook, demo ke klien, testing OAuth, dan akses remote."
---

## Apa Itu Ngrok

Ngrok adalah alat untuk membuka akses ke server lokal dari internet. Setelah dijalankan, ngrok menghasilkan URL publik yang mengarah ke localhost.

## Fungsi Utama Ngrok

### 1. Menerima Webhook

Webhook dari platform eksternal seperti WhatsApp, Stripe, atau GitHub membutuhkan URL publik. Ngrok menyediakan URL tersebut sehingga webhook bisa diterima di server lokal.

Contoh:

```bash
ngrok http 3000
```

URL `https://abc123.ngrok.io` dapat digunakan sebagai endpoint webhook.

### 2. Demo ke Klien

Hasil pengembangan yang masih berjalan di localhost dapat ditunjukkan ke klien tanpa perlu deploy ke server publik.

Cara penggunaan:

```bash
npm start
ngrok http 3000
```

URL yang dihasilkan dikirim ke klien untuk dilihat.

### 3. Testing dari Perangkat Lain

Aplikasi yang berjalan di localhost dapat diakses dari HP, tablet, atau komputer lain melalui URL ngrok.

### 4. Akses Remote ke Komputer

Jenis tunnel TCP pada ngrok memungkinkan akses ke port tertentu seperti SSH (port 22), Remote Desktop (3389), atau database (3306).

Contoh:

```bash
ngrok tcp 22
```

### 5. Testing OAuth

Layanan login seperti Google atau Facebook membutuhkan callback URL publik. Ngrok menyediakan URL tersebut untuk keperluan testing.

## Instalasi
Kamu dapat mengunjungi situs ini https://ngrok.com/download/ untuk mengunduh ngrok.

Berhubung saya menggunakan os linux, disini saya akan mencontohkan instalasi melalui linux sesuai dengan docs resmi ngrok

### 1. Instalasi ngrok agent
Masuk ke terminal bash dan masukan perintah berikut:
```bash
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list \
  && sudo apt update \
  && sudo apt install ngrok
```

Perintah di atas akan:
- Menambahkan GPG key ngrok ke sistem
- Menambahkan repository ngrok ke daftar sumber APT
- Mengupdate daftar paket
- Menginstall ngrok

### 2. Masukkan Auth Token
Setelah registrasi atau login di https://ngrok.com, buka dashboard dan salin auth token Anda.

Jalankan perintah berikut:

```bash
ngrok config add-authtoken "TOKEN_ANDA"
```

Ganti `TOKEN_ANDA` dengan token yang didapat dari dashboard.

### 3. Dapatkan URL Publik
Jalankan perintah berikut:

```bash
ngrok http 80
```

**Catatan tentang port:**
- Port disesuaikan dengan aplikasi yang sedang berjalan
- Jika aplikasi berjalan di port 8080, gunakan `ngrok http 8080`
- Jika aplikasi berjalan di port 3000, gunakan `ngrok http 3000`
- Jika aplikasi berjalan di port 8000, gunakan `ngrok http 8000`


Setelah perintah dijalankan, akan muncul tampilan seperti ini:

```
Forwarding  https://abc123.ngrok.io -> http://localhost:80
```

URL `https://abc123.ngrok.io` adalah URL publik yang dapat diakses dari internet untuk mengakses aplikasi lokal Anda.

## Perintah Dasar

| Perintah | Fungsi |
|----------|--------|
| ngrok http 3000 | Expose server HTTP di port 3000 |
| ngrok http 80 | Expose server di port 80 |
| ngrok tcp 22 | Expose port TCP (SSH) |
| ngrok http 3000 --host-header=localhost | Expose dengan custom host header |

## Keterbatasan Versi Gratis

- Subdomain acak (tidak bisa custom)
- Session maksimal 2-8 jam tergantung lalu lintas
- Tidak bisa menyimpan konfigurasi multiple tunnel

## Alternatif

- Localtunnel: `npx localtunnel --port 3000`
- Cloudflare Tunnel: `cloudflared tunnel`
- Serveo: `ssh -R 80:localhost:3000 serveo.net`

## Kesimpulan
Ngrok digunakan untuk membuka akses localhost ke internet. Fungsi utamanya meliputi penerimaan webhook, demo ke klien, testing lintas perangkat, akses remote, dan testing OAuth.