import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chillflix_app/data/models/user_list_model.dart';

void main() {
  group("UserList Model Tests", () {
    test("fromFirestore and toFirestore successful scenario", () {
      final timestamp = Timestamp.fromDate(DateTime(2025, 8, 30));
      final data = {
        "userId": "user_1",
        "movieId": "movie_1",
        "movieTitle": "Interstellar",
        "movieImageUrl": "https://example.com/interstellar.jpg",
        "addedAt": timestamp,
      };

      final userList = UserList.fromFirestore(data, "list_1");

      expect(userList.id, "list_1");
      expect(userList.userId, "user_1");
      expect(userList.movieId, "movie_1");
      expect(userList.movieTitle, "Interstellar");
      expect(userList.movieImageUrl, "https://example.com/interstellar.jpg");
      expect(userList.addedAt, timestamp.toDate());

      // 🔹 Check if toFirestore works correctly
      final map = userList.toFirestore();
      expect(map["userId"], "user_1");
      expect(map["movieId"], "movie_1");
      expect(map["addedAt"], timestamp);
    });

    test("fromFirestore uses default values or throws if data is missing", () {
      // 🔹 If addedAt is missing, it should throw an error
      final data = {
        "userId": "user_2",
        "movieId": "movie_2",
        "movieTitle": "Incomplete Movie",
        "movieImageUrl": "https://example.com/img.jpg",
        // "addedAt" is missing
      };

      try {
        UserList.fromFirestore(data, "list_2");
        fail("Should throw an error when addedAt is missing");
      } catch (e) {
        expect(e, isA<TypeError>()); // TypeError because Timestamp is missing
      }
    });

    test("Equatable props works correctly", () {
      final now = DateTime.now();
      final userList1 = UserList(
        id: "1",
        userId: "userA",
        movieId: "movieA",
        movieTitle: "TitleA",
        movieImageUrl: "imgA",
        addedAt: now,
      );

      final userList2 = UserList(
        id: "1",
        userId: "userA",
        movieId: "movieA",
        movieTitle: "TitleA",
        movieImageUrl: "imgA",
        addedAt: now,
      );

      expect(userList1, userList2); // Should be equal thanks to Equatable
    });
  });
}
