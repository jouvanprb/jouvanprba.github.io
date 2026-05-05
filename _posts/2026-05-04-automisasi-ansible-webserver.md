---
title: Automasi Instalasi Web Server dengan Ansible
description: >-
    Mempelajari konfigurasi Ansible untuk berkomunikasi dengan server web, pembuatan playbook otomatisasi instalasi Apache, serta pembuatan playbook khusus dengan instruksi instalasi yang spesifik.
author: jouvanprb
categories: [Infra as Code (IaC), Ansible]
tags: [Ansible, Apache, Web Server]
render_with_liquid: false
---

Dokumentasi ini membahas proses otomatisasi instalasi Apache pada server web menggunakan Ansible. Materi mencakup konfigurasi dasar Ansible agar dapat terhubung dan berkomunikasi dengan aplikasi webserver, pembuatan playbook untuk mengotomatiskan instalasi Apache secara keseluruhan, serta pengembangan playbook kustom yang mampu menjalankan instalasi Apache dengan instruksi yang lebih spesifik sesuai kebutuhan.


## 1. Menyiapkan Lingkungan Kerja

### 1.1 Instalasi Ansible

```bash
sudo apt install pipx -y
pipx install ansible-core
```

Setelah selesai, periksa versi Ansible:

```bash
ansible --version
```

### 1.2 Menyiapkan SSH di Server Target

Pastikan server target memiliki OpenSSH Server aktif:

```bash
sudo apt install openssh-server -y
sudo systemctl enable ssh --now
```

Verifikasi status layanan:

```bash
sudo systemctl status ssh
```

> Pastikan status menunjukkan **active (running)**.

---

### 1.3 Membuat Folder Proyek Ansible

```bash
mkdir ansible-apache
cd ansible-apache
```

---

## 2. Menyusun File Inventory (`hosts`)

Inventory mendefinisikan host target dan parameter koneksi.

```bash
nano hosts
```

Isi dengan (sesuaikan IP dan kredensial):

```ini
[webservers]
192.0.2.3 ansible_ssh_user=user ansible_ssh_pass=password!
```

> **Catatan:** Untuk lab lokal, Anda bisa menggunakan:
> ```ini
> [webservers]
> localhost ansible_connection=local
> ```

---

### 2.1 Verifikasi Koneksi Awal

```bash
ansible webservers -i hosts -m ping
```

Jika muncul error seperti ini:

```
FAILED! => {"msg": "Using a SSH password instead of a key is not possible because Host Key checking is enabled..."}
```

Tambahkan host fingerprint secara manual:

```bash
ssh user@ip
```

Ketik `yes` saat diminta konfirmasi, lalu keluar.

---

## 3. Konfigurasi `ansible.cfg`

Buat atau edit file konfigurasi Ansible:

```bash
nano ansible.cfg
```

Isi dengan:

```ini
[defaults]
# Gunakan file hosts lokal di folder ini
inventory=./hosts

# Abaikan verifikasi RSA Fingerprint
host_key_checking = False

# Jangan buat file retry
retry_files_enabled = False
```

**Penjelasan:**

| Konfigurasi | Fungsi |
|---|---|
| `inventory=./hosts` | Menunjuk ke file `hosts` di direktori yang sama sebagai sumber inventori |
| `host_key_checking = False` | Menonaktifkan pengecekan sidik jari SSH (berguna untuk lab) |
| `retry_files_enabled = False` | Mencegah Ansible membuat file `.retry` setelah menjalankan playbook |

---

### 3.1 Verifikasi Ulang Koneksi

```bash
ansible webservers -m ping
```

Output berhasil:

```
172.20.10.4 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.12"
    },
    "changed": false,
    "ping": "pong"
}
```

- **SUCCESS**: Koneksi berhasil
- **ping: pong**: Respons standar dari target
- **changed: false**: Tidak ada perubahan di sistem target

> **Warning Python Interpreter:** Ansible otomatis mencari Python di target. Warning muncul sebagai pemberitahuan bahwa interpreter bisa berubah jika Python versi baru diinstal. Untuk lab, ini aman diabaikan.

---

## 4. Uji Komunikasi dengan Command Module

```bash
ansible webservers -m command -a "/bin/echo hello world"
```

Output:

```
172.20.10.4 | CHANGED | rc=0 >>
hello world
```

- **CHANGED**: Perintah berhasil dieksekusi
- **rc=0**: Return code 0 (sukses, tidak ada error)
- **hello world**: Output dari perintah echo

---

## 5. Playbook Tes Echo

Buat file playbook pertama:

```bash
nano test_apache_playbook.yaml
```

Isi dengan:

```yaml
---
- hosts: webservers
  tasks:
    - name: run echo command
      command: /bin/echo hello world
```

Jalankan playbook:

```bash
ansible-playbook -v test_apache_playbook.yaml
```

Output:

```
PLAY [webservers]

TASK [Gathering Facts]
ok: [172.20.10.4]

TASK [run echo command]
changed: [172.20.10.4] => {"stdout": "hello world"}

PLAY RECAP
172.20.10.4    : ok=2    changed=1    unreachable=0    failed=0
```

---

## 6. Playbook Instalasi Apache

Buat file playbook baru:

```bash
nano install_apache_playbook.yaml
```

Isi dengan:

```yaml
---
- hosts: webservers
  become: yes
  tasks:
    - name: INSTALL APACHE2
      apt: name=apache2 update_cache=yes state=latest

    - name: ENABLED MOD_REWRITE
      apache2_module: name=rewrite state=present
      notify:
        - RESTART APACHE2

  handlers:
    - name: RESTART APACHE2
      service: name=apache2 state=restarted
```

**Penjelasan:**

| Baris | Fungsi |
|---|---|
| `become: yes` | Eskalasi sudo untuk instalasi paket |
| `apt: ... state=latest` | Instal Apache2 versi terbaru + update cache |
| `apache2_module: rewrite` | Aktifkan modul `mod_rewrite` |
| `notify` | Panggil handler RESTART APACHE2 jika task berubah |
| `handlers` | Hanya dijalankan jika dipicu `notify` |

Jalankan playbook:

```bash
ansible-playbook -v install_apache_playbook.yaml
```

> Jika muncul error `Missing sudo password`, jalankan dengan:
> ```bash
> ansible-playbook -v install_apache_playbook.yaml --ask-become-pass
> ```
> Masukkan password sudo saat diminta.

---

## 7. Playbook Instalasi Apache dengan Port Kustom 8081

Playbook ini mengubah port default Apache dari **80** menjadi **8081**. Berguna jika port 80 sudah dipakai aplikasi lain.

```bash
nano install_apache_options_playbook.yaml
```

Isi dengan:

```yaml
---
- hosts: webservers
  become: yes
  tasks:
    - name: INSTALL APACHE2
      apt: name=apache2 update_cache=no state=latest

    - name: ENABLED MOD_REWRITE
      apache2_module: name=rewrite state=present
      notify:
        - RESTART APACHE2

    - name: APACHE2 LISTEN ON PORT 8081
      lineinfile:
        dest: /etc/apache2/ports.conf
        regexp: "^Listen 80"
        line: "Listen 8081"
        state: present
      notify:
        - RESTART APACHE2

    - name: APACHE2 VIRTUALHOST ON PORT 8081
      lineinfile:
        dest: /etc/apache2/sites-available/000-default.conf
        regexp: "^<VirtualHost \\*:80>"
        line: "<VirtualHost *:8081>"
        state: present
      notify:
        - RESTART APACHE2

  handlers:
    - name: RESTART APACHE2
      service: name=apache2 state=restarted
```

---

### 7.1 Penjelasan Task Baru

**1. `APACHE2 LISTEN ON PORT 8081`**

Mengubah port yang didengarkan Apache dari **80** menjadi **8081** di file `/etc/apache2/ports.conf`. Modul `lineinfile` mencari baris yang diawali `Listen 80` lalu menggantinya dengan `Listen 8081`.

**2. `APACHE2 VIRTUALHOST ON PORT 8081`**

Mengubah konfigurasi VirtualHost default dari port **80** menjadi **8081** di file `/etc/apache2/sites-available/000-default.conf`. Ini memastikan VirtualHost merespons koneksi di port yang baru.

> Kedua file harus diubah bersamaan agar konfigurasi port sinkron.

---

### 7.2 Menjalankan Playbook

```bash
ansible-playbook -v install_apache_options_playbook.yaml --ask-become-pass
```

---

### 7.3 Verifikasi Hasil

```bash
cat /etc/apache2/ports.conf
# Output: Listen 8081

cat /etc/apache2/sites-available/000-default.conf
# Output: <VirtualHost *:8081>
```

---

## Kesimpulan

Setelah menyelesaikan lab ini, kita telah mempelajari:

1. **Konfigurasi Ansible** — Menyiapkan file `hosts` dan `ansible.cfg` untuk komunikasi dengan server target.
2. **Uji Koneksi** — Menggunakan modul `ping` dan `command` untuk verifikasi koneksi.
3. **Playbook Otomatisasi** — Membuat playbook instalasi Apache2, aktivasi `mod_rewrite`, dan kustomisasi port dari 80 ke 8081.
4. **Konsep Penting** — Memahami `become` (sudo), `handler` & `notify` (restart hanya saat perlu), serta `lineinfile` (edit file konfigurasi).

Dengan Ansible, instalasi dan konfigurasi server yang tadinya manual kini bisa diotomatisasi ke banyak server sekaligus — cepat, konsisten, dan minim kesalahan.