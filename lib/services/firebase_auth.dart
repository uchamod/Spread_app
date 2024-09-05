import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signup user from username and password
  Future<UserCredential> createUserWithUsernameAndPassword(
      String username, String password) async {
    String name = "$username@gmail.com";
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: name, password: password);
      return userCredential;
      // } on FirebaseAuthException catch (e) {
      //   print('Error creating user: ${mapFirebaseAuthExceptionCode(e.code)}');
      //   throw Exception(mapFirebaseAuthExceptionCode(e.code));
    } catch (err) {
      print("user_authentication_error: ${err.toString()}");
      throw Exception(err.toString());
    }
  }

  //massage hadler

  mapFirebaseAuthExceptionCode(String code) {}
  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //singout user
  Future<void> singOut() async {
    try {
      _auth.signOut();
    } catch (err) {
      print("sing out error : ${err.toString()}");
      throw Exception(err);
    }
  }

  //singIn User with Username&password
  Future<void> singInUser(String username, String password) async {
    String email = "$username@gmail.com";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      print('Error signing in: ${mapFirebaseAuthExceptionCode(e.code)}');
    } catch (err) {
      print("error while SingIn: ${err.toString()}");
      throw Exception(err);
    }
  }
}
