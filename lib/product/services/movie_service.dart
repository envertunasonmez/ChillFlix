import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie_model.dart';
import '../models/user_list_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MovieService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔹 Belirli kategoriye göre filmleri getir
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
      print("🔍 Top10Movies çekiliyor: category='top_movie'");

      final query = await _firestore
          .collection('movies')
          .where('category', isEqualTo: 'top_movie')
          .get();

      print("📊 Bulunan doküman sayısı: ${query.docs.length}");

      if (query.docs.isEmpty) {
        print("⚠️ top_movie kategorisinde hiç doküman bulunamadı");
      }

      List<Movie> movies = query.docs
          .map((doc) => Movie.fromFirestore(doc.data(), doc.id))
          .toList();

      print("🎬 Dönüştürülen film sayısı: ${movies.length}");

      // Client-side sorting eğer rating field'ı varsa
      movies.sort((a, b) => b.rating.compareTo(a.rating));

      // İlk 10 tanesini al
      return movies.take(10).toList();
    } catch (e) {
      print("❌ Top10Movies hatası: $e");
      throw Exception("Top10 Movies alınamadı: $e");
    }
  }

  Future<List<Movie>> getTop10Series() async {
    try {
      print("🔍 Top10Series çekiliyor: category='top_series'");

      final query = await _firestore
          .collection('movies')
          .where('category', isEqualTo: 'top_series')
          .get();

      print("📊 Bulunan doküman sayısı: ${query.docs.length}");

      if (query.docs.isEmpty) {
        print("⚠️ top_series kategorisinde hiç doküman bulunamadı");
      }

      List<Movie> movies = query.docs
          .map((doc) => Movie.fromFirestore(doc.data(), doc.id))
          .toList();

      print("🎬 Dönüştürülen film sayısı: ${movies.length}");

      // Client-side sorting eğer rating field'ı varsa
      movies.sort((a, b) => b.rating.compareTo(a.rating));

      // İlk 10 tanesini al
      return movies.take(10).toList();
    } catch (e) {
      print("❌ Top10Series hatası: $e");
      throw Exception("Top10 Series alınamadı: $e");
    }
  }

  /// 🔹 Kullanıcının listesine film ekle/çıkar
  Future<bool> addToUserList(
      String movieId, String movieTitle, String movieImageUrl) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("Kullanıcı giriş yapmamış");

      final userListRef = _firestore.collection('user_lists');

      // Aynı film zaten var mı kontrol et
      final existing = await userListRef
          .where('userId', isEqualTo: userId)
          .where('movieId', isEqualTo: movieId)
          .get();

      if (existing.docs.isNotEmpty) {
        // varsa kaldır
        await userListRef.doc(existing.docs.first.id).delete();
        return false;
      } else {
        // yoksa ekle
        await userListRef.add({
          'userId': userId,
          'movieId': movieId,
          'movieTitle': movieTitle,
          'movieImageUrl': movieImageUrl,
          'addedAt': FieldValue.serverTimestamp(),
        });
        return true;
      }
    } catch (e) {
      throw Exception("User list güncellenemedi: $e");
    }
  }

  /// 🔹 Kullanıcının listesi
  Future<List<UserList>> getUserList() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("Kullanıcı giriş yapmamış");

      final query = await _firestore
          .collection('user_lists')
          .where('userId', isEqualTo: userId)
          .orderBy('addedAt', descending: true)
          .get();

      return query.docs
          .map((doc) => UserList.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception("User list alınamadı: $e");
    }
  }

  /// 🔹 Kullanıcının listesinde mi?
  Future<bool> isInUserList(String movieId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return false;

      final query = await _firestore
          .collection('user_lists')
          .where('userId', isEqualTo: userId)
          .where('movieId', isEqualTo: movieId)
          .get();

      return query.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// 🔹 Kullanıcının listesinden kaldır
  Future<bool> removeFromUserList(String listId) async {
    try {
      await _firestore.collection('user_lists').doc(listId).delete();
      return true;
    } catch (e) {
      throw Exception("Film listeden kaldırılamadı: $e");
    }
  }
}
