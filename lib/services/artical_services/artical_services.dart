import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spread/models/artical.dart';
import 'package:spread/services/common_functions.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/services/storage.dart';
import 'package:spread/util/constants.dart';
import 'package:uuid/uuid.dart';

class ArticalServices {
  //microblog collection
  final CollectionReference _blogCollection;
  // FirebaseFirestore.instance.collection("microblogs");
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("users");
  final AuthServices _authServices = AuthServices();
  final FirebaseStorage _storage = FirebaseStorage.instance;

//make testable -dependency injjection
  ArticalServices({FirebaseFirestore? firebasefirestore})
      : _blogCollection = (firebasefirestore ?? FirebaseFirestore.instance)
            .collection("microblogs");
  Future<void> addBlog(String title, String content, File image,
      List<String> tags, String url, BuildContext context) async {
    try {
      String blogId = Uuid().v1();
      //get image url
      String imageUrl = await StorageServices()
          .uploadBlogImage("MicroBlogPosts", image, blogId);

      User? user = FirebaseAuth.instance.currentUser;

      Artical artical = Artical(
          articalId: blogId,
          title: title,
          discription: content,
          tags: tags,
          userId: user!.uid,
          likes: [],
          publishedDate: DateTime.now(),
          images: imageUrl,
          weblink: url,
          dislike: []);

      //uploading
      await _blogCollection.doc(blogId).set(artical.toJson());
      CommonFunctions().massage("Upload Arrtical Succsussfuly",
          Icons.check_circle, Colors.green, context, 2);
      //notify followers
      DocumentSnapshot userDoc = await _userCollection.doc(user.uid).get();
      List<dynamic> followers = userDoc['followers'] ?? [];

      // Send notification to each follower
      for (String followerId in followers) {
        DocumentSnapshot followerDoc =
            await _userCollection.doc(followerId).get();
        String? token = followerDoc['fcmToken'];

        if (token != null) {
          await sendNotification(token, user.displayName!, title, artical);
        }
      }
    } catch (err) {
      print("blog uploding error $err");
      CommonFunctions()
          .massage("Fail to Upload", Icons.cancel, errorColor, context, 2);
    }
  }

  //get followers tokens
  Future<void> sendNotification(
      String token, String userName, String title, Artical artical) async {
    final String serverKey =
        'AIzaSyDcwMUqXSUhyiWNhml4L35hsudlaWs4A30'; // Add your Firebase Cloud Messaging server key here

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode({
        'to': token,
        'notification': {
          'title': 'New Post Alert!',
          'body': '$userName posted a new $title. Check it out!',
          'sound': 'default',
          'artical': artical
        }
      }),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification');
    }
  }
}
