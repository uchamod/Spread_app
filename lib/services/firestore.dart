import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/people.dart';
import 'package:spread/services/common_functions.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/services/storage.dart';
import 'package:spread/util/constants.dart';
import 'package:uuid/uuid.dart';

class FirestoreServices {
  //user collection
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("users");
  //microblog collection
  final CollectionReference _blogCollection =
      FirebaseFirestore.instance.collection("microblogs");
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

  //add new microblog
  Future<void> addBlog(String title, String content, File image,
      List<String> tags, String url, BuildContext context) async {
    try {
      //get image url
      String imageUrl =
          await StorageServices().uploadImage("MicroBlogPosts", image, true);

      User? user = FirebaseAuth.instance.currentUser;
      String blogId = Uuid().v4();
      Artical artical = Artical(
          articalId: blogId,
          title: title,
          discription: content,
          tags: tags,
          userId: user!.uid,
          likes: [],
          publishedDate: DateTime.now(),
          images: imageUrl,
          weblink: url);

      //uploading
      await _blogCollection.doc(blogId).set(artical.toJson());
      CommonFunctions().massage("Upload Arrtical Succsussfuly",
          Icons.check_circle, Colors.green, context);
    } catch (err) {
      print("blog uploding error $err");
      CommonFunctions()
          .massage("Fail to Upload", Icons.cancel, errorColor, context);
    }
  }
}
