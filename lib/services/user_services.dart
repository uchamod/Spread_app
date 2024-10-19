import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spread/models/people.dart';
import 'package:spread/services/common_functions.dart';
import 'package:spread/util/constants.dart';

class UserServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference _videoCollection =
      FirebaseFirestore.instance.collection("videos");
  final CollectionReference _arrticalCollection =
      FirebaseFirestore.instance.collection("microblogs");
  //get user by user id
  Future<People?> getUserById(String id) async {
    try {
      final userDocument =
          await _firebaseFirestore.collection("users").doc(id).get();
      if (userDocument.exists) {
        return People.fromJson(userDocument.data() as Map<String, dynamic>);
      }
    } catch (err) {
      print("error from getUserById method $err");
      return null;
    }
  }

  //follow user
  Future<void> followUser(
      String userId, String foreingId, BuildContext context) async {
    try {
      DocumentSnapshot inUser =
          await _firebaseFirestore.collection("users").doc(userId).get();
      List followings = (inUser.data() as dynamic)["following"];
      if (followings.contains(foreingId)) {
        //unfollow from current user
        await _firebaseFirestore.collection("users").doc(userId).update({
          "following": FieldValue.arrayRemove([foreingId])
        });
        //unfollow from forieng user
        await _firebaseFirestore.collection("users").doc(foreingId).update({
          "followers": FieldValue.arrayRemove([userId])
        });
      } else {
        //following from current user
        await _firebaseFirestore.collection("users").doc(userId).update({
          "following": FieldValue.arrayUnion([foreingId])
        });
        //add followers to forieng user
        await _firebaseFirestore.collection("users").doc(foreingId).update({
          "followers": FieldValue.arrayUnion([userId])
        });
      }
    } catch (err) {
      print("user follwing error $err");
      CommonFunctions()
          .massage("Network Error", Icons.cancel, errorColor, context);
    }
  }

  //like on Media
  Future<void> likeOnMedia(String userId, String mediaId, bool isVideo) async {
    try {
      DocumentSnapshot documentSnapshot = isVideo
          ? await _videoCollection.doc(mediaId).get()
          : await _arrticalCollection.doc(mediaId).get();

      List likes = (documentSnapshot.data() as Map<String, dynamic>)["likes"];
      List dislikes =
          (documentSnapshot.data() as Map<String, dynamic>)["dislike"];
      if (likes.contains(userId)) {
        //dislike
        isVideo
            ? await _videoCollection.doc(mediaId).update({
                "likes": FieldValue.arrayRemove([userId])
              })
            : await _arrticalCollection.doc(mediaId).update({
                "likes": FieldValue.arrayRemove([userId])
              });
      } else {
        //like
        if (dislikes.contains(userId)) {
          isVideo
              ? await _videoCollection.doc(mediaId).update({
                  "dislike": FieldValue.arrayRemove([userId])
                })
              : await _arrticalCollection.doc(mediaId).update({
                  "dislike": FieldValue.arrayRemove([userId])
                });
        }
        isVideo
            ? await _videoCollection.doc(mediaId).update({
                "likes": FieldValue.arrayUnion([userId])
              })
            : await _arrticalCollection.doc(mediaId).update({
                "likes": FieldValue.arrayUnion([userId])
              });
      }
    } catch (err) {
      print("fail to like $err");
    }
  }

  //dislike
  Future<void> disLikeOnMedia(
      String userId, String mediaId, bool isVideo) async {
    try {
      DocumentSnapshot documentSnapshot = isVideo
          ? await _videoCollection.doc(mediaId).get()
          : await _arrticalCollection.doc(mediaId).get();

      List dislikes =
          (documentSnapshot.data() as Map<String, dynamic>)["dislike"];
      List likes = (documentSnapshot.data() as Map<String, dynamic>)["likes"];
      if (dislikes.contains(userId)) {
        //remove dislike
        isVideo
            ? await _videoCollection.doc(mediaId).update({
                "dislike": FieldValue.arrayRemove([userId])
              })
            : await _arrticalCollection.doc(mediaId).update({
                "dislike": FieldValue.arrayRemove([userId])
              });
      } else {
        //dislike

        if (likes.contains(userId)) {
          isVideo
              ? await _videoCollection.doc(mediaId).update({
                  "likes": FieldValue.arrayRemove([userId])
                })
              : await _arrticalCollection.doc(mediaId).update({
                  "likes": FieldValue.arrayRemove([userId])
                });
        }
        isVideo
            ? await _videoCollection.doc(mediaId).update({
                "dislike": FieldValue.arrayUnion([userId])
              })
            : await _arrticalCollection.doc(mediaId).update({
                "dislike": FieldValue.arrayUnion([userId])
              });
      }
    } catch (err) {
      print("fail to like $err");
    }
  }
}
