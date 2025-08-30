import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie_model.dart';
import '../models/user_list_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MovieService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current user getter
  String? get _currentUserId => _auth.currentUser?.uid;

  // Auth durumu kontrolü
  bool get isUserLoggedIn => _auth.currentUser != null;

  /// Belirli kategoriye göre filmleri getir
  Future<List<Movie>> getMoviesByCategory(String category) async {
    try {
      final query = await _firestore
          .collection('movies')
          .where('category', isEqualTo: category)
          .get();

      return query.docs
          .map((doc) => Movie.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception("Kategoriye göre film alınamadı: $e");
    }
  }

  Future<List<Movie>> getTop10Movies() async {
    try {
      print("Top10Movies çekiliyor: category='top_movie'");

      final query = await _firestore
          .collection('movies')
          .where('category', isEqualTo: 'top_movie')
          .get();

      print("Bulunan doküman sayısı: ${query.docs.length}");

      if (query.docs.isEmpty) {
        print("top_movie kategorisinde hiç doküman bulunamadı");
      }

      List<Movie> movies = query.docs
          .map((doc) => Movie.fromFirestore(doc.data(), doc.id))
          .toList();

      print("Dönüştürülen film sayısı: ${movies.length}");

      // Client-side sorting
      movies.sort((a, b) => b.rating.compareTo(a.rating));

      return movies.take(10).toList();
    } catch (e) {
      print("Top10Movies hatası: $e");
      throw Exception("Top10 Movies alınamadı: $e");
    }
  }

  Future<List<Movie>> getTop10Series() async {
    try {
      print("Top10Series çekiliyor: category='top_series'");

      final query = await _firestore
          .collection('movies')
          .where('category', isEqualTo: 'top_series')
          .get();

      print("Bulunan doküman sayısı: ${query.docs.length}");

      List<Movie> movies = query.docs
          .map((doc) => Movie.fromFirestore(doc.data(), doc.id))
          .toList();

      movies.sort((a, b) => b.rating.compareTo(a.rating));

      return movies.take(10).toList();
    } catch (e) {
      print("Top10Series hatası: $e");
      throw Exception("Top10 Series alınamadı: $e");
    }
  }

  /// Kullanıcının listesine film ekle/çıkar (Toggle)
  Future<bool> addToUserList(
      String movieId, String movieTitle, String movieImageUrl) async {
    if (!isUserLoggedIn) {
      throw Exception("Kullanıcı giriş yapmamış");
    }

    try {
      final userId = _currentUserId!;
      final userListRef = _firestore.collection('user_lists');

      // Aynı film zaten var mı kontrol et
      final existingQuery = await userListRef
          .where('userId', isEqualTo: userId)
          .where('movieId', isEqualTo: movieId)
          .get();

      if (existingQuery.docs.isNotEmpty) {
        // Film zaten listede varsa kaldır
        await userListRef.doc(existingQuery.docs.first.id).delete();
        print("Film listeden çıkarıldı: $movieTitle");
        return false; // Film çıkarıldı
      } else {
        // Film listede yoksa ekle
        await userListRef.add({
          'userId': userId,
          'movieId': movieId,
          'movieTitle': movieTitle,
          'movieImageUrl': movieImageUrl,
          'addedAt': FieldValue.serverTimestamp(),
        });
        print("Film listeye eklendi: $movieTitle");
        return true; // Film eklendi
      }
    } catch (e) {
      print("addToUserList hatası: $e");
      throw Exception("User list güncellenemedi: $e");
    }
  }

  /// Kullanıcının listesini getir
  Future<List<UserList>> getUserList() async {
    if (!isUserLoggedIn) {
      throw Exception("Kullanıcı giriş yapmamış");
    }

    try {
      final userId = _currentUserId!;

      print("Kullanıcı listesi getiriliyor, userId: $userId");

      final query = await _firestore
          .collection('user_lists')
          .where('userId', isEqualTo: userId)
          .orderBy('addedAt', descending: true)
          .get();

      print("Kullanıcı listesinde bulunan film sayısı: ${query.docs.length}");

      final userList = query.docs
          .map((doc) => UserList.fromFirestore(doc.data(), doc.id))
          .toList();

      // Debug için
      for (var item in userList) {
        print("User List Film: ${item.movieTitle} - ${item.movieImageUrl}");
      }

      return userList;
    } catch (e) {
      print("getUserList hatası: $e");
      throw Exception("User list alınamadı: $e");
    }
  }

  /// Film kullanıcının listesinde mi kontrol et
  Future<bool> isInUserList(String movieId) async {
    if (!isUserLoggedIn) return false;

    try {
      final userId = _currentUserId!;

      final query = await _firestore
          .collection('user_lists')
          .where('userId', isEqualTo: userId)
          .where('movieId', isEqualTo: movieId)
          .get();

      final isInList = query.docs.isNotEmpty;
      print("Film $movieId listede mi: $isInList");

      return isInList;
    } catch (e) {
      print("isInUserList hatası: $e");
      return false;
    }
  }

  /// Kullanıcının listesinden film kaldır (ID ile)
  Future<bool> removeFromUserList(String listId) async {
    if (!isUserLoggedIn) {
      throw Exception("Kullanıcı giriş yapmamış");
    }

    try {
      // Önce dokümanı kontrol et
      final doc = await _firestore.collection('user_lists').doc(listId).get();

      if (!doc.exists) {
        throw Exception("Liste öğesi bulunamadı");
      }

      // Güvenlik: Sadece kendi listesinden silebilir
      final data = doc.data()!;
      if (data['userId'] != _currentUserId) {
        throw Exception("Bu liste öğesini silme yetkiniz yok");
      }

      await _firestore.collection('user_lists').doc(listId).delete();
      print("Film listeden kaldırıldı, listId: $listId");

      return true;
    } catch (e) {
      print("removeFromUserList hatası: $e");
      throw Exception("Film listeden kaldırılamadı: $e");
    }
  }

  /// Kullanıcının listesinden film kaldır (Movie ID ile)
  Future<bool> removeFromUserListByMovieId(String movieId) async {
    if (!isUserLoggedIn) {
      throw Exception("Kullanıcı giriş yapmamış");
    }

    try {
      final userId = _currentUserId!;

      final query = await _firestore
          .collection('user_lists')
          .where('userId', isEqualTo: userId)
          .where('movieId', isEqualTo: movieId)
          .get();

      if (query.docs.isEmpty) {
        print("Kaldırılacak film bulunamadı: $movieId");
        return false;
      }

      // İlk bulunan dokümanı sil
      await _firestore
          .collection('user_lists')
          .doc(query.docs.first.id)
          .delete();
      print("Film movieId ile kaldırıldı: $movieId");

      return true;
    } catch (e) {
      print("removeFromUserListByMovieId hatası: $e");
      throw Exception("Film listeden kaldırılamadı: $e");
    }
  }

  /// Auth durumu dinleyici
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Kullanıcı bilgileri
  User? get currentUser => _auth.currentUser;
  String? get currentUserEmail => _auth.currentUser?.email;
  String? get currentUserDisplayName => _auth.currentUser?.displayName;
}
