import 'package:flutter_test/flutter_test.dart';
import 'package:chillflix_app/data/models/movie_model.dart';

void main() {
  group("Movie Model Tests", () {
    test("fromFirestore and toFirestore successful scenario", () {
      // 🔹 Simulate data coming from Firestore
      final data = {
        "title": "Interstellar",
        "description": "Space adventure",
        "imageUrl": "https://example.com/interstellar.jpg",
        "category": "sci-fi",
        "rating": 9.0,
        "year": 2014,
        "duration": 169,
      };

      final movie = Movie.fromFirestore(data, "movie_1");

      expect(movie.id, "movie_1");
      expect(movie.title, "Interstellar");
      expect(movie.description, "Space adventure");
      expect(movie.imageUrl, "https://example.com/interstellar.jpg");
      expect(movie.category, "sci-fi");
      expect(movie.rating, 9.0);
      expect(movie.year, 2014);
      expect(movie.duration, 169);

      // 🔹 Check if toFirestore works correctly
      final map = movie.toFirestore();
      expect(map["title"], "Interstellar");
      expect(map["rating"], 9.0);
    });

    test("fromFirestore uses default values if data is incomplete", () {
      // 🔹 Only title is provided, others are missing
      final data = {
        "title": "Incomplete Movie",
      };

      final movie = Movie.fromFirestore(data, "movie_2");

      expect(movie.id, "movie_2");
      expect(movie.title, "Incomplete Movie");
      expect(movie.description, ""); // default
      expect(movie.imageUrl, ""); // default
      expect(movie.category, ""); // default
      expect(movie.rating, 0.0); // default
      expect(movie.year, 0); // default
      expect(movie.duration, 0); // default
    });

    test("Equatable props works correctly", () {
      final movie1 = Movie(id: "1", title: "A", description: "", imageUrl: "", category: "");
      final movie2 = Movie(id: "1", title: "A", description: "", imageUrl: "", category: "");

      expect(movie1, movie2); // Should be equal thanks to Equatable
    });
  });
}
