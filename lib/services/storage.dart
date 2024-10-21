import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //upload profile Pic
  Future<String> uploadImage(
      String folder, File image, bool isNotProfile) async {
    try {
      Reference reference =
          _storage.ref().child(folder).child(_auth.currentUser!.uid);
      if (isNotProfile) {
        String extraId = const Uuid().v1();
        reference.child(extraId);
        print("set extra id");
      }

      UploadTask uploadTask = reference.putFile(
        image,
        SettableMetadata(
          contentType: 'image/jpeg',
        ),
      );

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (err) {
      print("upload task error: ${err.toString()}");
      throw Exception(err.toString());
    }
  }

  //upload blog post
  Future<String> uploadBlogImage(String folder, File image,String blogId) async {
    try {
    
      Reference reference = _storage
          .ref()
          .child(folder)
          .child(_auth.currentUser!.uid)
          .child(blogId);

      UploadTask uploadTask = reference.putFile(
        image,
        SettableMetadata(
          contentType: 'image/jpeg',
        ),
      );

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (err) {
      print("upload task error: ${err.toString()}");
      throw Exception(err.toString());
    }
  }

  //upload video
  Future<String> uploadVideo(File videofile,String videoId) async {
    try {
      
      Reference reference = await _storage
          .ref()
          .child("videos")
          .child(_auth.currentUser!.uid)
          .child(videoId);
      await reference.putFile(videofile);
      String url = await reference.getDownloadURL();
      return url;
    } catch (err) {
      print('Error uploading video: $err');
      throw err;
    }
  }
}
