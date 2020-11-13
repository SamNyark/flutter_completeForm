import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  static String errorMessage;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  // ignore: missing_return
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<dynamic> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if(e.code == 'wrong-password') {
        errorMessage = "Incorrect Password";
      } 
      if (e.code == 'user-not-found') {
        errorMessage = "Incorret user credentials";
      }
      if (e.code == 'invalid-email') {
        errorMessage = "Invalid email";
      }
      
      
    }
  }

  Future<dynamic> signUp({String email, String password, }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("account created");
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        errorMessage = "Email already in use";
      }
    }
  }
}
