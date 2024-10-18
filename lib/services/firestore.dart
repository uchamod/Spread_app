import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spread/models/artical.dart';
import 'package:spread/models/comment.dart';
import 'package:spread/models/people.dart';
import 'package:spread/models/watch_now.dart';
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
  //video collection
  final CollectionReference _videoCollection =
      FirebaseFirestore.instance.collection("videos");
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
          await StorageServices().uploadBlogImage("MicroBlogPosts", image);

      User? user = FirebaseAuth.instance.currentUser;
      String blogId = Uuid().v1();
      Artical artical = Artical(
          articalId: blogId,
          title: title,
          discription: content,
          tags: tags,
          userId: user!.uid,
          likes: [],
          publishedDate: Timestamp.now(),
          images: imageUrl,
          weblink: url);

      //uploading
      await _blogCollection.doc(blogId).set(artical.toJson());
      CommonFunctions().massage("Upload Arrtical Succsussfuly",
          Icons.check_circle, Colors.green, context);
      //notify followers
      DocumentSnapshot userDoc = await _userCollection.doc(user.uid).get();
      List<dynamic> followers = userDoc['followers'] ?? [];

      // Send notification to each follower
      for (String followerId in followers) {
        DocumentSnapshot followerDoc =
            await _userCollection.doc(followerId).get();
        String? token = followerDoc['fcmToken'];

        if (token != null) {
          await sendNotification(token, user.displayName!, title,artical);
        }
      }
    } catch (err) {
      print("blog uploding error $err");
      CommonFunctions()
          .massage("Fail to Upload", Icons.cancel, errorColor, context);
    }
  }

  //add new video
  Future<void> addVideo(String title, File image, File videofile,
      List<String> tags, String url, BuildContext context) async {
    try {
      String videoId = Uuid().v1();
      //get video url
      String videoUrl = await StorageServices().uploadVideo(videofile);
      //get thubnail url
      String imageUrl =
          await StorageServices().uploadBlogImage("thubnails", image);
      User? user = FirebaseAuth.instance.currentUser;
      Videos video = Videos(
          videoId: videoId,
          title: title,
          tags: tags,
          videoUrl: videoUrl,
          tubnail: imageUrl,
          userId: user!.uid,
          likes: [],
          publishedDate: Timestamp.now(),
          weblink: url);
      //upload video
      await _videoCollection.doc(videoId).set(video.toJson());
      CommonFunctions().massage("Upload video Succsussfuly", Icons.check_circle,
          Colors.green, context);
    } catch (err) {
      print("video uploding error $err");
      CommonFunctions()
          .massage("Fail to Upload", Icons.cancel, errorColor, context);
    }
  }

  //comment on video or microblog
  Future<void> commentOnMedia(
      Comment comment, bool isForVideo, BuildContext context) async {
    try {
      if (isForVideo) {
        await _videoCollection
            .doc(comment.docId)
            .collection("comments")
            .doc(comment.commentId)
            .set(comment.toJson());
      } else {
        await _blogCollection
            .doc(comment.docId)
            .collection("comments")
            .doc(comment.commentId)
            .set(comment.toJson());
      }
    } catch (err) {
      print("Fail to comment $err");
      CommonFunctions()
          .massage("Fail to Upload", Icons.cancel, errorColor, context);
    }
  }

  //get followers tokens
  Future<void> sendNotification(
      String token, String userName, String title,Artical artical) async {
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
          'artical':artical
        }
      }),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification');
    }
  }

  // Future<List<String>> getFollowersTokens(String userId) async {
  //   DocumentSnapshot followers = await _userCollection.doc(userId).get();
  //   List<String?> followersList =
  //       (followers.data() as Map<String, dynamic>)["followers"];
  //   List<String> tokens = [];
  //   for (String? follower in followersList) {
  //     DocumentSnapshot user = await _userCollection.doc(follower).get();
  //     if (user.exists) {
  //       tokens.add(user['fcmToken']);
  //     }
  //   }
  //   return tokens;
  // }
}
