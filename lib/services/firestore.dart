import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spread/models/people.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/services/storage.dart';

class FirestoreServices {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("users");
  final AuthServices _authServices = AuthServices();

  //save new user in database
  Future<String> saveNewUser(String username, String password,
      File profileImage, String discription, String location) async {
    try {
      //create new user
      UserCredential newUser = await _authServices
          .createUserWithUsernameAndPassword(username, password);
      //uploadprofile pic and get link
      String imageUrl = await StorageServices()
          .uploadImage("ProfilePics", profileImage, false);
      String userid = newUser.user!.uid;
      People user = People(
          userId: userid,
          name: username,
          discription: discription,
          location: location,
          password: password,
          image: imageUrl,
          followers: [],
          followings: [],
          joinedDate: DateTime.now(),
          updatedDate: DateTime.now());

      await _userCollection.doc(userid).set(user.toJson());
      return "Succsussfuly Registerd";
    } catch (err) {
      return "Something went wrong";
    }
  }
}
