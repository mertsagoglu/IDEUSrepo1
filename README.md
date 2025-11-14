# Shell Scripting Assignments  
CSE – Bash Scripting Exercises  
Repository Owner: **mertsagoglu**

Bu repo, iki farklı Bash script ödevini içermektedir:

1. **disk_usage.sh** — Disk kullanım analiz scripti  
2. **caesar.sh** — Caesar Cipher şifreleme scripti  

Her ikisi de standart Unix araçlarını (`du`, `sort`, `head`, `tr`, `cut`, vb.) kullanarak yazılmıştır ve verilen otomatik test scriptleri ile uyumludur.

---

# 📌 1. disk_usage.sh

## 🔹 Açıklama
`disk_usage.sh`, verilen dizin(leri) analiz ederek en çok yer kaplayan klasör veya dosyaları listeler.  
Aşağıdaki özellikleri destekler:

- `-a` → Dosyaları **dahil** eder (default: sadece dizinler)  
- `-n N` → En büyük **N** sonucu gösterir (varsayılan: 10)  
- Birden fazla dizin argümanı kabul eder  
- Hataları bastırmak için `2>/dev/null` kullanır  
- `getopts` ile flag parsing yapılmıştır  

---

## 🔹 Kullanım
```
./disk_usage.sh [-a -n N] directory...
```

### Örnekler:
```
./disk_usage.sh /etc
./disk_usage.sh -n 5 /etc
./disk_usage.sh -a /etc
./disk_usage.sh -a -n 3 /etc /var
```

---

## 🔹 İç Mantık
- Eğer `-a` varsa → `du -ah`  
- Yoksa → `du -h --max-depth=1`  
- Sonuçlar → `sort -hr | head -n N`

Test script ile uyumludur:
```
test_disk_usage.sh
```

---

# 📌 2. caesar.sh

## 🔹 Açıklama
`caesar.sh`, Caesar Cipher (ROT-N) şifrelemesi yapan bir Bash scriptidir.

Özellikler:

- Varsayılan rotasyon: **13 (ROT13)**  
- Kullanıcı bir sayı verirse: o kadar rotasyon  
- 26’dan büyük sayılarda → mod 26 uygulanır  
- Uppercase ve lowercase harfler ayrı korrekt işlendi  
- Harf olmayan karakterlere dokunulmaz  
- `tr` ile dinamik karakter seti oluşturulur  

---

## 🔹 Kullanım
```
./caesar.sh [rotation]
```

### Örnekler:
```
echo "Hello World" | ./caesar.sh
echo "Hello World" | ./caesar.sh 10
echo "Test!" | ./caesar.sh 40
```

---

## 🔹 İç Mantık
- Rotasyon mod 26 uygulanır  
- Upper ve lower kaynak setleri:  
  - `ABCDEFGHIJKLMNOPQRSTUVWXYZ`  
  - `abcdefghijklmnopqrstuvwxyz`  
- Target setleri substring ile oluşturulur:  
  - `${SRC_UP:ROT}${SRC_UP:0:ROT}`  
- `tr` ile dönüştürme yapılır  

Script, resmi test scripti ile uyumludur:
```
test_caesar.sh
```

---

# 📌 Kurulum ve Çalıştırma

### Çalıştırma izni ver:
```
chmod +x disk_usage.sh
chmod +x caesar.sh
```

### Test scriptlerini indir ve çalıştır:
```
curl -O http://www3.nd.edu/~pbui/teaching/cse.20189.sp16/static/sh/test_disk_usage.sh
chmod +x test_disk_usage.sh
./test_disk_usage.sh
```

```
curl -O http://www3.nd.edu/~pbui/teaching/cse.20189.sp16/static/sh/test_caesar.sh
chmod +x test_caesar.sh
./test_caesar.sh
```

---

# 📌 Notlar
- Scriptler POSIX shell yapısına uygun yazılmıştır.
- Test scriptleri bazı Linux dağıtımlarında farklı `du` çıktıları verebildiği için doğru çalışma **test dizinleri üzerinden** yapılmalıdır.
- Bu repo eğitim amaçlı hazırlanmıştır.

---

# ✔️ Hazırlayan
**Mert Sağoğlu**  
GitHub: [@mertsagoglu](https://github.com/mertsagoglu)
