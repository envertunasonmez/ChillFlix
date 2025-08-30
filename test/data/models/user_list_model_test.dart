import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chillflix_app/data/models/user_list_model.dart';

void main() {
  group("UserList Model Tests", () {
    test("fromFirestore ve toFirestore başarılı senaryo", () {
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

      // 🔹 toFirestore doğru çalışıyor mu?
      final map = userList.toFirestore();
      expect(map["userId"], "user_1");
      expect(map["movieId"], "movie_1");
      expect(map["addedAt"], timestamp);
    });

    test(
        "fromFirestore eksik veri ile çağrıldığında default değerler kullanılır",
        () {
      // 🔹 addedAt eksik olursa hata verir, bunu try-catch ile test ediyoruz
      final data = {
        "userId": "user_2",
        "movieId": "movie_2",
        "movieTitle": "Incomplete Movie",
        "movieImageUrl": "https://example.com/img.jpg",
        // "addedAt" eksik
      };

      try {
        UserList.fromFirestore(data, "list_2");
        fail("Eksik addedAt ile hata alınmalıydı");
      } catch (e) {
        expect(e, isA<TypeError>()); // Timestamp eksik olduğu için TypeError
      }
    });

    test("props ile Equatable çalışıyor", () {
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

      expect(userList1, userList2); // Equatable sayesinde eşit olmalı
    });
  });
}
