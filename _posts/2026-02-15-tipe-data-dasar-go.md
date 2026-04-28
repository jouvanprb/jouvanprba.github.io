---
title: Tipe Data Dasar Go
author: jouvanprb
date: 2026-02-15 11:50:00 +0700
categories: [Programming, Go]
tags: [golang, data-type]
render_with_liquid: false
---

Dalam Bahasa pemrogramman, tipe data merupakan hal yang sangat penting untuk dipahami, karena merupakan fondasi utama dalam menulis code. Begitu juga hal nya di `Golang`{: .filepath}, tipe data digunakan untuk menentukan jenis nilai yang dapat disimpan dalam variabel.


## Tipe Data String
Tipe Data `String`{: .filepath} digunakan untuk menyimpan Teks.

var digunakan untuk mendeklarasikan variabel dalam Go dengan atau tanpa tipe data eksplisit. 
```go
var nama string = "Jouvan"
```

Gunakan backtick (`) untuk string multi baris.
```go
profil := `Mahasiswa. Semester akhir
Telkom University.`
```


## Tipe Data Numerik

###  **Integer**
  
  Tipe Data Integer berfungsi untuk menyimpan nilai bilangan bulat, baik positif maupun negatif.

  ```go
var usia int = 20
  ```
  `Golang`{: .filepath} menyediakan beberapa variasi integer `int`,`int8`,`int16`,`int32`,`int64`,`uint`,`uint8`,`uint16`,`uint32`,`uint64`.

### **Float**
  
  Untuk bilangan desimal, kita bisa menggunakan `float32` atau `float64`.

  ```go
var tinggi float64 = 171.2
  ```

##  Tipe Data Boolean

Tipe Data Boolean hanya memiki 2 nilai yaitu: `True`{: .filepath} atau `False`{: .filepath}.

```go
var mahasiswa bool = true
```
pada pernyataan `if` boolean sangat sering digunakan.

##  Tipe Data Default

Tipe data default merupakan tipe data yang dideklarasikan tanpa tipe atau secara eksplisit. Tipe data akan ditentukan berdasarkan nilai.

```go
var nama = "Jouvan"
var umur = 20
var mahasiswa = true
```

##  Zero Value

Zero value adalah nilai default yang otomatis diberikan oleh Golang ketika kita membuat variabel tanpa mengisi nilainya.

| Tipe Data                 | Zero Value |             Contoh Kode             |
| ------------------------- | :--------: | :---------------------------------: |
| Integer (int, int32, dll) |     0      |      var angka int → angka = 0      |
| Float (float32, float64)  |    0.0     | var desimal float64 → desimal = 0.0 |
| String                    |     ""     |     var teks string → teks = ""     |
| Boolean                   |   false    | var kondisi bool → kondisi = false  |

Contoh:
```go
var angka int
fmt.Println(angka) // Output: 0
```

