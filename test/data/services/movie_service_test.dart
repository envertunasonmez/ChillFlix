import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chillflix_app/data/models/movie_model.dart';
import 'package:chillflix_app/data/services/movie_service.dart';

// 🔹 Mock sınıflar
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  late MovieService movieService;
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late MockCollectionReference mockCollection;
  late MockQuery mockQuery;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQueryDocumentSnapshot mockDoc;
  late MockDocumentReference mockDocRef;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockCollection = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockDoc = MockQueryDocumentSnapshot();
    mockDocRef = MockDocumentReference();

    when(() => mockAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn("testUserId");

    movieService = MovieService(firestore: mockFirestore, auth: mockAuth);
  });

  group("MovieService Tests", () {
    test("getMoviesByCategory başarılı senaryo", () async {
      when(() => mockFirestore.collection("movies")).thenReturn(mockCollection);
      when(() => mockCollection.where("category", isEqualTo: "sci-fi"))
          .thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(() => mockQuerySnapshot.docs).thenReturn([mockDoc]);
      when(() => mockDoc.data()).thenReturn({
        "title": "Interstellar",
        "description": "Space movie",
        "imageUrl": "imgUrl",
        "category": "sci-fi",
        "rating": 9.0,
        "year": 2014,
        "duration": 169,
      });
      when(() => mockDoc.id).thenReturn("movie_1");

      final result = await movieService.getMoviesByCategory("sci-fi");

      expect(result, isA<List<Movie>>());
      expect(result.length, 1);
      expect(result.first.title, "Interstellar");
    });

    test("addToUserList başarılı (film ekleme)", () async {
      final userLists = MockCollectionReference();
      final queryMock = MockQuery();
      final snapshotMock = MockQuerySnapshot();

      when(() => mockFirestore.collection("user_lists")).thenReturn(userLists);
      when(() => userLists.where("userId", isEqualTo: "testUserId"))
          .thenReturn(queryMock);
      when(() => queryMock.where("movieId", isEqualTo: "movie_1"))
          .thenReturn(queryMock);
      when(() => queryMock.get()).thenAnswer((_) async => snapshotMock);
      when(() => snapshotMock.docs).thenReturn([]);

      // 🔹 Burada null yerine DocumentReference döndür
      when(() => userLists.add(any())).thenAnswer((_) async => mockDocRef);

      final result =
          await movieService.addToUserList("movie_1", "Interstellar", "imgUrl");
      expect(result, true);
    });

    test("addToUserList başarısız (kullanıcı yok)", () async {
      when(() => mockAuth.currentUser).thenReturn(null);

      final service = MovieService(firestore: mockFirestore, auth: mockAuth);

      expect(() async => await service.addToUserList("id", "title", "img"),
          throwsA(isA<Exception>()));
    });

    test("isInUserList başarılı ve false senaryoları", () async {
      final userLists = MockCollectionReference();
      final queryMock = MockQuery();
      final snapshotMock = MockQuerySnapshot();

      when(() => mockFirestore.collection("user_lists")).thenReturn(userLists);
      when(() => userLists.where("userId", isEqualTo: "testUserId"))
          .thenReturn(queryMock);
      when(() => queryMock.where("movieId", isEqualTo: "movie_1"))
          .thenReturn(queryMock);
      when(() => queryMock.get()).thenAnswer((_) async => snapshotMock);

      // True senaryo
      when(() => snapshotMock.docs).thenReturn([mockDoc]);
      final isInList = await movieService.isInUserList("movie_1");
      expect(isInList, true);

      // False senaryo
      when(() => snapshotMock.docs).thenReturn([]);
      final isInListFalse = await movieService.isInUserList("movie_1");
      expect(isInListFalse, false);
    });
  });
}
