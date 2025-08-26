import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserList extends Equatable {
  final String id;
  final String userId;
  final String movieId;
  final String movieTitle;
  final String movieImageUrl;
  final DateTime addedAt;

  const UserList({
    required this.id,
    required this.userId,
    required this.movieId,
    required this.movieTitle,
    required this.movieImageUrl,
    required this.addedAt,
  });

  factory UserList.fromFirestore(Map<String, dynamic> data, String id) {
    return UserList(
      id: id,
      userId: data['userId'] ?? '',
      movieId: data['movieId'] ?? '',
      movieTitle: data['movieTitle'] ?? '',
      movieImageUrl: data['movieImageUrl'] ?? '',
      addedAt: (data['addedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'movieId': movieId,
      'movieTitle': movieTitle,
      'movieImageUrl': movieImageUrl,
      'addedAt': Timestamp.fromDate(addedAt),
    };
  }

  @override
  List<Object?> get props =>
      [id, userId, movieId, movieTitle, movieImageUrl, addedAt];
}
