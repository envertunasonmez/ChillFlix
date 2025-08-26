# ChillFlix - Netflix Clone

Firebase entegrasyonu ile geliştirilmiş Netflix benzeri film ve dizi izleme uygulaması.

## Özellikler

- 🔐 Firebase Authentication ile kullanıcı girişi
- 🎬 Kategorilere göre film ve dizi listeleme
- ⭐ Most Wanted, Only on ChillFlix, Coming Soon, Everyone Watch These kategorileri
- 📊 Top 10 Films ve Top 10 Series listeleri
- 📋 Kullanıcı kişisel listesi (Listem)
- 🌍 Türkçe ve İngilizce dil desteği
- 📱 Responsive tasarım

## Firebase Kurulumu

### 1. Firebase Projesi Oluşturma

1. [Firebase Console](https://console.firebase.google.com/)'a gidin
2. "Add project" ile yeni proje oluşturun
3. Proje adını "chillflix-app" olarak belirleyin

### 2. Authentication Kurulumu

1. Sol menüden "Authentication" seçin
2. "Get started" butonuna tıklayın
3. "Sign-in method" sekmesinde "Email/Password" etkinleştirin
4. "Enable" yapın

### 3. Firestore Database Kurulumu

1. Sol menüden "Firestore Database" seçin
2. "Create database" butonuna tıklayın
3. "Start in test mode" seçin
4. Bölge olarak "europe-west1" seçin

### 4. Flutter Uygulamasına Firebase Ekleme

1. Firebase Console'da "Project settings" > "General" sekmesine gidin
2. "Your apps" bölümünde "Android" simgesine tıklayın
3. Android package name: `com.example.chillflix_app`
4. `google-services.json` dosyasını indirin
5. İndirilen dosyayı `android/app/` klasörüne kopyalayın

6. iOS için:
   - "iOS" simgesine tıklayın
   - Bundle ID: `com.example.chillflixApp`
   - `GoogleService-Info.plist` dosyasını indirin
   - iOS klasörüne ekleyin

### 5. Firestore Veri Ekleme

`firebase_data_setup.dart` dosyasındaki örnek verileri Firestore'a ekleyin:

1. Firestore Database > Data > "Start collection"
2. Collection ID: `movies`
3. Her bir film için ayrı document oluşturun
4. Örnek veriler:

```json
{
  "title": "The Dark Knight",
  "description": "Batman'in Joker ile mücadelesi",
  "imageUrl": "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
  "category": "most_wanted",
  "rating": 9.0,
  "year": 2008,
  "duration": 152,
  "genres": ["Action", "Crime", "Drama"],
  "director": "Christopher Nolan",
  "cast": ["Christian Bale", "Heath Ledger", "Aaron Eckhart"],
  "isSeries": false,
  "seasonCount": 0,
  "createdAt": Timestamp.now()
}
```

### 6. Firestore Kuralları

Firestore Database > Rules bölümüne şu kuralları ekleyin:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Film verilerini herkes okuyabilir
    match /movies/{document} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    
    // Kullanıcı listesi sadece kendi kullanıcısı okuyabilir/yazabilir
    match /userLists/{document} {
      allow read, write: if request.auth != null && request.auth.uid == resource.data.userId;
    }
  }
}
```

## Kategoriler

### 1. Most Wanted
- En popüler ve yüksek puanlı filmler
- `category: "most_wanted"`

### 2. Only on ChillFlix
- Platform özel içerikler
- `category: "only_on_chillflix"`

### 3. Coming Soon
- Yakında gelecek içerikler
- `category: "coming_soon"`

### 4. Everyone Watch These
- Herkesin izlemesi gereken içerikler
- `category: "everyone_watch_these"`

### 5. Top 10 Films
- En iyi 10 film (isSeries: false)
- Rating'e göre sıralanır

### 6. Top 10 Series
- En iyi 10 dizi (isSeries: true)
- Rating'e göre sıralanır

## Listem Özelliği

- Kullanıcılar film kartlarındaki "+" butonuna basarak filmi listesine ekleyebilir
- Profil sayfasında "Listem" bölümünde eklenen filmler görünür
- "-" butonu ile listeden çıkarabilir
- Her kullanıcının kendi listesi ayrı tutulur

## Firebase Collections

### movies Collection
```
{
  title: String,
  description: String,
  imageUrl: String,
  category: String,
  rating: Number,
  year: Number,
  duration: Number,
  genres: Array<String>,
  director: String,
  cast: Array<String>,
  isSeries: Boolean,
  seasonCount: Number,
  createdAt: Timestamp
}
```

### userLists Collection
```
{
  userId: String,
  movieId: String,
  movieTitle: String,
  movieImageUrl: String,
  addedAt: Timestamp
}
```

## Kurulum

```bash
# Bağımlılıkları yükle
flutter pub get

# Uygulamayı çalıştır
flutter run
```

## Teknolojiler

- Flutter
- Firebase (Authentication, Firestore)
- BLoC Pattern
- Flutter Localizations
- Google Fonts

## Lisans

Bu proje eğitim amaçlı geliştirilmiştir.
