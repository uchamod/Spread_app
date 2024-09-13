import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spread/models/people.dart';
import 'package:spread/services/common_functions.dart';
import 'package:spread/util/constants.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //signup user from username and password
  Future<UserCredential> createUserWithUsernameAndPassword(
      String username, String password) async {
    String name = "$username@gmail.com";
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: name, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error creating user: ${mapFirebaseAuthExceptionCode(e.code)}');
      throw Exception(mapFirebaseAuthExceptionCode(e.code));
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

  //singIn with google
  Future<void> googleSingIn(BuildContext context) async {
    try {
      // Trigger the Google Sign In process
      final GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
      if (signInAccount == null) {
        return;
      }
      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication signInAuthentication =
          await signInAccount.authentication;
      // Create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken,
      );
      // Sign in to Firebase with the Google Auth credential
      final UserCredential userCredentials =
          await _auth.signInWithCredential(credentials);
      final user = userCredentials.user;
      if (user != null) {
        final People newUser = People(
          userId: user.uid,
          name: user.displayName ?? "",
          discription: "",
          location: "",
          password: user.email ?? "",
          image: user.photoURL,
          followers: [],
          followings: [],
          joinedDate: DateTime.now(),
          updatedDate: DateTime.now(),
        );

        await _firestore
            .collection("users")
            .doc(user.uid)
            .set(newUser.toJson());
        CommonFunctions().massage(
            "succssusfuly registed", Icons.check_circle, Colors.green, context);
      }
    } on FirebaseAuthException catch (error) {
      throw mapFirebaseAuthExceptionCode(error.code);
    } catch (err) {
      print("google sing in error: ${err.toString()}");
      CommonFunctions()
          .massage("Something went wrong", Icons.cancel, errorColor, context);
    }
  }

  //anomymous sing in
  Future<void> anonymousSingIn(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      if (user != null) {
        print("succssussfuly sing in");
        CommonFunctions()
            .massage("Sing In anonymous", Icons.check_circle, Colors.green, context);
      }
    } on FirebaseAuthException catch (error) {
      throw mapFirebaseAuthExceptionCode(error.code);
    } catch (err) {
         print("google sing in error: ${err.toString()}");
      CommonFunctions()
          .massage("Something went wrong", Icons.cancel, errorColor, context);
    }
  }
}
