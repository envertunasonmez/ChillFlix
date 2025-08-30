import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie_model.dart';
import '../models/user_list_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MovieService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current user getter
  String? get _currentUserId => _auth.currentUser?.uid;

  // Authenticated check
  bool get isUserLoggedIn => _auth.currentUser != null;

  /// Fetch movies by category
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
      throw Exception("Movies by category could not be retrieved: $e");
    }
  }

  Future<List<Movie>> getTop10Movies() async {
    try {
      final query = await _firestore
          .collection('movies')
          .where('category', isEqualTo: 'top_movie')
          .get();

      if (query.docs.isEmpty) {}

      List<Movie> movies = query.docs
          .map((doc) => Movie.fromFirestore(doc.data(), doc.id))
          .toList();

      // Client-side sorting
      movies.sort((a, b) => b.rating.compareTo(a.rating));

      return movies.take(10).toList();
    } catch (e) {
      throw Exception("Top10 Movies could not be retrieved: $e");
    }
  }

  Future<List<Movie>> getTop10Series() async {
    try {
      final query = await _firestore
          .collection('movies')
          .where('category', isEqualTo: 'top_series')
          .get();

      List<Movie> movies = query.docs
          .map((doc) => Movie.fromFirestore(doc.data(), doc.id))
          .toList();

      movies.sort((a, b) => b.rating.compareTo(a.rating));

      return movies.take(10).toList();
    } catch (e) {
      throw Exception("Top10 Series could not be obtained: $e");
    }
  }

  /// Add or remove a movie from the user's list
  Future<bool> addToUserList(
      String movieId, String movieTitle, String movieImageUrl) async {
    if (!isUserLoggedIn) {
      throw Exception("User not logged in");
    }

    try {
      final userId = _currentUserId!;
      final userListRef = _firestore.collection('user_lists');

      // Check if the movie is already in the user's list
      final existingQuery = await userListRef
          .where('userId', isEqualTo: userId)
          .where('movieId', isEqualTo: movieId)
          .get();

      if (existingQuery.docs.isNotEmpty) {
        // Film already in list, remove it
        await userListRef.doc(existingQuery.docs.first.id).delete();
        return false; // Film removed
      } else {
        // Film not in list, add it
        await userListRef.add({
          'userId': userId,
          'movieId': movieId,
          'movieTitle': movieTitle,
          'movieImageUrl': movieImageUrl,
          'addedAt': FieldValue.serverTimestamp(),
        });
        return true; // Film added
      }
    } catch (e) {
      throw Exception("User list could not be updated: $e");
    }
  }

  /// Get the user's movie list
  Future<List<UserList>> getUserList() async {
    if (!isUserLoggedIn) {
      throw Exception("User not logged in");
    }

    try {
      final userId = _currentUserId!;

      final query = await _firestore
          .collection('user_lists')
          .where('userId', isEqualTo: userId)
          .orderBy('addedAt', descending: true)
          .get();

      final userList = query.docs
          .map((doc) => UserList.fromFirestore(doc.data(), doc.id))
          .toList();

      return userList;
    } catch (e) {
      throw Exception("User list could not be retrieved: $e");
    }
  }

  /// Check if a movie is in the user's list
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

      return isInList;
    } catch (e) {
      return false;
    }
  }

  /// Remove a movie from the user's list by list ID
  Future<bool> removeFromUserList(String listId) async {
    if (!isUserLoggedIn) {
      throw Exception("User not logged in");
    }

    try {
      // Verify the list item exists and belongs to the current user
      final doc = await _firestore.collection('user_lists').doc(listId).get();

      if (!doc.exists) {
        throw Exception("List item not found");
      }

      // Check ownership
      final data = doc.data()!;
      if (data['userId'] != _currentUserId) {
        throw Exception("You do not have permission to delete this list item.");
      }

      await _firestore.collection('user_lists').doc(listId).delete();

      return true;
    } catch (e) {
      throw Exception("Film couldn't remove from list: $e");
    }
  }

  /// Remove a movie from the user's list by movie ID
  Future<bool> removeFromUserListByMovieId(String movieId) async {
    if (!isUserLoggedIn) {
      throw Exception("User not log in");
    }

    try {
      final userId = _currentUserId!;

      final query = await _firestore
          .collection('user_lists')
          .where('userId', isEqualTo: userId)
          .where('movieId', isEqualTo: movieId)
          .get();

      if (query.docs.isEmpty) {
        return false;
      }

      // Delete the document
      await _firestore
          .collection('user_lists')
          .doc(query.docs.first.id)
          .delete();

      return true;
    } catch (e) {
      throw Exception("Film couldn't remove: $e");
    }
  }

  /// Authentication state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Current user info
  User? get currentUser => _auth.currentUser;
  String? get currentUserEmail => _auth.currentUser?.email;
  String? get currentUserDisplayName => _auth.currentUser?.displayName;
}
