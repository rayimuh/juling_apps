import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:juling_apps/provider/auth_user.dart';

import '../mock_auth.dart';
import 'provider_auth_test.mocks.dart';

@GenerateMocks([UserCredential, FirebaseAuth, User])
void main() {
  setupFirebaseAuthMocks();
  group('AuthProvider Tests', () {
    late AuthProvider authProvider;
    late MockFirebaseAuth mockAuth;
    late MockUser mockUser;
    late MockUserCredential mockUserCredential;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      mockUser = MockUser();
      mockUserCredential = MockUserCredential();
      authProvider = AuthProvider();
      authProvider.auth = mockAuth;
      authProvider.user = mockUser;
    });

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    test('initializeUser sets the current user', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);

      await authProvider.initializeUser();

      expect(authProvider.user, mockUser);
    });

    test('signInWithEmailAndPassword sets user on success', () async {
      when(mockAuth.signInWithEmailAndPassword(
              email: "rayi@gmail.com", password: "harmoni19"))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockAuth.currentUser).thenReturn(mockUser);
      await authProvider.signInWithEmailAndPassword(
          'rayi@gmail.com', 'harmoni19');

      expect(authProvider.user, mockUser);
    });

    test('signOut sets user to null', () async {
      await authProvider.signOut();

      expect(authProvider.user, isNull);
    });

    test('isSignedIn returns true when user is not null', () {
      authProvider.user = mockUser;

      expect(authProvider.isSignedIn, true);
    });

    test('isSignedIn returns false when user is null', () {
      authProvider.user = null;

      expect(authProvider.isSignedIn, false);
    });
  });
}
