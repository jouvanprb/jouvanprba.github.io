---
title: "Docker dalam CI/CD Pipeline"
author: jouvanprb
categories: [Containerization, Docker]
description: >-
    Artikel ini mempelajari tentang apa itu Docker, Docker vs Virtual Machine, bagaimana Docker membantu dalam CI/CD (konsistensi enviroment, isolasi, portabilitas)
tags: [docker, continuous integration, CI/CD pipeline, DevOps]
image: /posts/20260607/docker-thumbnail.webp
render_with_liquid: false
pin: true
---

## Apa itu Docker
Docker adalah platform perangkat lunak yang memungkinkan Anda membuat, menguji, dan menerapkan aplikasi dengan cepat. Docker mengemas perangkat lunak ke dalam unit standar yang disebut kontainer yang memiliki semua yang diperlukan perangkat lunak agar dapat berfungsi termasuk pustaka, alat sistem, kode, dan waktu proses. Dengan menggunakan Docker, kita dapat dengan cepat menerapkan dan menskalakan aplikasi ke lingkungan apa pun dan yakin bahwa kode Anda akan berjalan.

Contohnya adalah saat anda mendeploy program anda pada docker, maka ketika anda membagikan program anda pada orang lain, orang tersebut tidak harus dipusingkan untuk menginstal environtment yang dibutuhkan untuk menjalankan program tersebut karena secara otomatis docker akan menyiapkan kebutuhan environtment dari program tersebut. hal ini akan mempermudah developer untuk lebih fokus dalam melakukan penulisan kode saja dan tidak dipusingkan dengan deployment.

### Berikut perbandingan menggunakan Docker dan tanpa Docker
#### Komponen Sistem (Tanpa Docker)
```
┌─────────────────────────────────────┐
│         OUR APPLICATION             │  ← Kode aplikasi kita
├─────────────────────────────────────┤
│         DATABASE / WEB SERVER       │  ← Service yang dijalankan
├─────────────────────────────────────┤
│         RUNTIME APP                 │  ← Node.js / Python / JVM
├─────────────────────────────────────┤
│         LIBRARY                     │  ← libc, openssl, dll
├─────────────────────────────────────┤
│         SISTEM OPERASI              │  ← Kernel OS (Windows/Linux)
├─────────────────────────────────────┤
│         HOST / SERVER               │  ← Mesin fisik atau virtual
└─────────────────────────────────────┘
```

#### Docker Container (Membungkus Semua Kebutuhan)
```
┌─────────────────────────────────────────────┐
│              DOCKER CONTAINER               │
│  ┌───────────────────────────────────────┐  │
│  │         OUR APPLICATION               │  │
│  ├───────────────────────────────────────┤  │
│  │         DATABASE / WEB SERVER         │  │
│  ├───────────────────────────────────────┤  │
│  │         RUNTIME APP                   │  │
│  ├───────────────────────────────────────┤  │
│  │         LIBRARY                       │  │
│  └───────────────────────────────────────┘  │
│              ↓ (berbagi kernel)             │
│         SISTEM OPERASI (HOST)               │
│              ↓                              │
│         HOST / SERVER                       │
└─────────────────────────────────────────────┘
```

Begini konsep container pada docker. Container pada docker digunakan untuk mengemas program kita dengan standarisasi yang sudah ditentukan. Oleh karena itu apabila container tersebut akan dijalankan pada sistem operasi lain atau komputer lain maka tidak perlu melakukan penyesuaian pada environtement untuk dapat menjalankan program karena setup environtement sudah dikemas didalam container bersamaan dengan program anda.

## Docker vs Virtual Machine 
Secara sekilas, jika dilihat mengenai cara kerja container pada docker sedikit
mirip dengan konsep virtual machine. Namun apakah docker container
merupakan sebuah virtual machine? Untuk menjawab hal tersebut kita akan
bedah menganai apa itu virtual machine dan apa itu container.

#### a. Virtual Machine
Virtual machine adalah program perangkat lunak atau sistem operasi
virtual yang bisa digunakan pada sebuah perangkat keras bersamaan
dengan OS asli perangkat tersebut. VM akan diinstal pada hypervisor dan
5memiliki fungsi layaknya duplikat dari komputer asli dengan sistem
operasi berbeda.

#### b. Docker Container
Container merupakan suatu teknik yang dapat digunakan untuk
menciptakan sistem yang terisolasi (isolated environtment) pada level
sistem operasi yang dijalankan pada satu induk kernel (linux).

![comparison docker vs vm](/posts/20260607/virtual-machine-vs-Docker.webp) 

Jika diperhatikan gambar diatas, ada beberapa perbedaan mendasar antara virtual machine dengan container. Untuk virtual machine sendiri dia
akan berjalan pada hypervisor sehingga satu komputer bisa memiliki banyak sistem operasi. Sedangkan untuk container, dia akan berjalan pada sistem operasi dan bukan hypervisor sehingga dalam satu sistem operasi dapat memiliki banyak container.

## Apakah Docker termasuk CI/CD Tools
Docker bukanlah CI/CD tools. CI/CD tools adalah perangkat lunak yang secara khusus dirancang untuk melakukan otomatisasi proses build, testing, dan deployment, seperti Jenkins, GitLab CI, atau GitHub Actions. Sementara itu, Docker adalah platform container yang berfungsi untuk mengemas aplikasi beserta seluruh dependensinya ke dalam unit yang portabel dan konsisten. Meskipun demikian, Docker sering dikaitkan dengan CI/CD karena ia memainkan peran yang sangat penting dalam mendukung kelancaran pipeline CI/CD. Dengan Docker, pengembang dapat memastikan bahwa lingkungan pengujian dan produksi identik, sehingga menghilangkan masalah "works on my machine".

Ketika diintegrasikan dengan CI/CD tools, setiap kali pengembang melakukan push kode ke repository, CI/CD tools dapat secara otomatis menjalankan perintah Docker seperti **docker build** untuk membuat image, **docker test** untuk menguji container, dan **docker push** untuk mengirimkan image ke registry, lalu dilanjutkan dengan deployment otomatis ke server. Karena kemampuannya yang sangat membantu dalam proses otomatisasi dan deployment berkelanjutan, banyak orang menganggap Docker sebagai bagian dari ekosistem CI/CD. Namun secara teknis dan fungsional, Docker tidak dapat berdiri sendiri sebagai CI/CD tools karena ia tidak memiliki kemampuan untuk melakukan trigger build berdasarkan perubahan kode, menjalankan rangkaian test secara terstruktur, atau mengelola pipeline deployment secara native. Dengan kata lain, Docker adalah alat yang memperkuat dan menyempurnakan CI/CD, bukan CI/CD tools itu sendiri. Istilah yang lebih tepat adalah CI/CD pipeline yang menggunakan Docker.

## Kesimpulan

Docker bukanlah CI/CD tools, melainkan **platform container** yang sangat membantu kelancaran pipeline CI/CD. Dengan kemampuannya menstandarisasi environment, mengemas aplikasi beserta semua dependensinya, serta memastikan portabilitas lintas platform, Docker menjadi **alat yang memperkuat** implementasi CI/CD di berbagai tim pengembangan. Jadi, ketika Anda mendengar istilah "CI/CD dengan Docker", itu berarti Docker digunakan sebagai **bagian dari pipeline**, bukan sebagai pengganti tools CI/CD seperti Jenkins atau GitHub Actions.