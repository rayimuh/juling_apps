import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;   
  bool isLoading = false;

  AuthProvider() {
    initializeUser();
  }

  Future<void> initializeUser() async {
    user = auth.currentUser;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "User Not Found");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong Password");
      }
    } finally {  
      initializeUser();          
      isLoading = false;      
      notifyListeners();      
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    user = null;
    notifyListeners();
  }

  bool get isSignedIn => user != null;
}
