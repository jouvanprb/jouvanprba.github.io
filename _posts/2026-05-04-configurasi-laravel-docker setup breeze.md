---
title: Setup Laravel Breeze dengan Docker Compose
author: jouvanprb
categories: [Framework, Laravel]
description : >-
    Mempelajari setup Laravel Breeze untuk membangun sistem autentikasi otomatis meliputi login, register, forgot password, email verification, dan profil. Semua fitur siap pakai dalam hitungan menit menggunakan Docker Compose.
tags: [docker, laravel, laravel-breeze, authentication]
render_with_liquid: false
---

Laravel Breeze adalah starter kit autentikasi resmi dari Laravel yang ringan dan minimalis. Menyediakan fitur login, register, forgot password, email verification, dan profil. Cocok untuk project yang ingin memiliki sistem autentikasi siap pakai tanpa konfigurasi manual.

## Prasyarat

Pastikan environment Laravel Docker Compose sudah berjalan. Jika belum, ikuti panduan setup di [artikel sebelumnya](#).

## Langkah 1: Install Laravel Breeze via Composer

Masuk ke direktori project Laravel lalu jalankan perintah berikut:

```bash
# Pastikan berada di direktori laravel-app
cd laravel-app

# Install Laravel Breeze
docker exec -it laravel-docker composer require laravel/breeze --dev  

## Langkah 2: Install Breeze Stack

Laravel Breeze mendukung beberapa stack frontend. Pilih salah satu:

### Opsi A: Blade (Default - Tanpa Framework JS)
```bash
docker exec -it laravel-docker php artisan breeze:install blade
```

### Opsi B: React
```bash
docker exec -it laravel-docker php artisan breeze:install react
```

### Opsi C: Vue
```bash
docker exec -it laravel-docker php artisan breeze:install vue
```

### Opsi D: Livewire (Menggunakan Laravel Volt)
```bash
docker exec -it laravel-docker php artisan breeze:install livewire
```

Pada panduan ini, kita akan menggunakan **Blade** karena paling ringan dan tidak memerlukan Node.js tambahan.

```bash
docker exec -it laravel-docker php artisan breeze:install blade
```

**Output yang muncul:**
```
Installing Laravel Breeze (blade)...

  ✔ Created routes/auth.php
  ✔ Created app/Http/Controllers/Auth/...
  ✔ Created resources/views/auth/...
  ✔ Created resources/views/components/...
  ✔ Created resources/views/layouts/...
  ✔ Created resources/views/profile/...
  ✔ Created tests/Feature/Auth/...

  Breeze scaffolding installed successfully.
```

---

## Langkah 3: Jalankan Migrasi Database

Breeze otomatis menambahkan tabel baru untuk fitur autentikasi. Jalankan migrasi:

```bash
docker exec -it laravel-docker php artisan migrate
```

**Output:**
```
Migration table created successfully.
Migrating: 0001_01_01_000000_create_users_table
Migrated:  0001_01_01_000000_create_users_table
Migrating: 0001_01_01_000001_create_cache_table
Migrated:  0001_01_01_000001_create_cache_table
Migrating: 0001_01_01_000002_create_jobs_table
Migrated:  0001_01_01_000002_create_jobs_table
```

---

## Langkah 4: Install dan Build Frontend (Opsional)

Jika memilih stack **Blade**, frontend sudah langsung siap pakai tanpa build tambahan.

Jika memilih **React** atau **Vue**, perlu menjalankan:

```bash
# Install dependency Node.js
docker exec -it laravel-docker npm install

# Build assets
docker exec -it laravel-docker npm run build
```

> **Catatan:** Pastikan Node.js tersedia di container. Jika belum, tambahkan di Dockerfile atau jalankan secara lokal.

---

## Langkah 5: Akses Aplikasi

Buka browser dan kunjungi:

```text
http://localhost:8000
```

## Langkah 6: Test Fitur Autentikasi

### Register
Klik **Register** di pojok kanan atas, isi form:

| Field | Isi Contoh |
|-------|------------|
| Name | Jouvan |
| Email | jouvan@example.com |
| Password | password123 |
| Confirm Password | password123 |

Klik **Register** maka kamu akan langsung login dan diarahkan ke **Dashboard**.

### Login
Jika sudah punya akun, klik **Login** di navbar dan masukkan email & password yang sudah terdaftar.

### Forgot Password
Pada halaman **Login**, klik link **Forgot password** untuk mengirim email reset password (pastikan konfigurasi email di `.env` sudah benar).

### Profil
Setelah login, klik nama user di pojok kanan atas lalu pilih **Profile**. Di sini kamu bisa:
- Update nama dan email
- Ganti password
- Hapus akun

## Struktur File yang Ditambahkan Breeze

Setelah instalasi, berikut file dan folder baru yang dibuat:

```
app/Http/Controllers/Auth/
├── AuthenticatedSessionController.php
├── ConfirmablePasswordController.php
├── EmailVerificationNotificationController.php
├── EmailVerificationPromptController.php
├── NewPasswordController.php
├── PasswordController.php
├── PasswordResetLinkController.php
├── RegisteredUserController.php
└── VerifyEmailController.php

app/Http/Requests/Auth/
└── LoginRequest.php

resources/views/
├── auth/
│   ├── confirm-password.blade.php
│   ├── forgot-password.blade.php
│   ├── login.blade.php
│   ├── register.blade.php
│   ├── reset-password.blade.php
│   └── verify-email.blade.php
├── components/
├── dashboard.blade.php
├── layouts/
└── profile/
    ├── edit.blade.php
    └── partials/

routes/
└── auth.php

tests/Feature/Auth/
├── AuthenticationTest.php
├── EmailVerificationTest.php
├── PasswordConfirmationTest.php
├── PasswordResetTest.php
├── PasswordUpdateTest.php
└── RegistrationTest.php
```

---

## Customisasi Breeze

### 1. Mengganti Redirect Setelah Login/Register

Buka `app/Http/Controllers/Auth/AuthenticatedSessionController.php`:

```php
// Ganti dari
return redirect()->intended(route('dashboard', absolute: false));

// Menjadi
return redirect()->intended(route('home', absolute: false));
```

### 2. Menambahkan Field di Form Register

Edit `resources/views/auth/register.blade.php` dan tambahkan input baru, lalu update model `User.php` dan migrasi.

### 3. Mengganti Tampilan

Semua view Blade bisa diedit di folder `resources/views/auth/` dan `resources/views/components/`.

### 4. Mengaktifkan Email Verification

Di model `User.php`, implementasikan interface `MustVerifyEmail`:

```php
use Illuminate\Contracts\Auth\MustVerifyEmail;

class User extends Authenticatable implements MustVerifyEmail
{
    // ...
}
```

---

## Troubleshooting

### Error: Breeze scaffolding not found
```bash
# Pastikan Breeze terinstall
docker exec -it laravel-docker composer show laravel/breeze

# Jika belum, install ulang
docker exec -it laravel-docker composer require laravel/breeze --dev
```

### Error: Migration table not found
```bash
# Reset database dan migrate ulang
docker exec -it laravel-docker php artisan migrate:fresh
```

### CSS/Tailwind tidak muncul
```bash
# Jika pakai React/Vue
docker exec -it laravel-docker npm install
docker exec -it laravel-docker npm run build
```

---

## Selesai

Dengan Laravel Breeze, kamu mendapatkan sistem autentikasi lengkap dalam hitungan menit. Tanpa perlu membuat login, register, forgot password, dan dashboard dari nol — semuanya sudah disediakan oleh Breeze secara otomatis.
```

