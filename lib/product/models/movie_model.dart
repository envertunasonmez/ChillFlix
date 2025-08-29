import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final double rating;
  final int year;
  final int duration;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.rating = 0.0,
    this.year = 0,
    this.duration = 0,
  });

  factory Movie.fromFirestore(Map<String, dynamic> data, String id) {
    return Movie(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      year: data['year'] ?? 0,
      duration: data['duration'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'rating': rating,
      'year': year,
      'duration': duration,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        category,
        rating,
        year,
        duration,
      ];
}
