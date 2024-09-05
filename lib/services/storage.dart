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
    Reference reference =
        _storage.ref().child(folder).child(_auth.currentUser!.uid);
    if (isNotProfile) {
      String extraId = const Uuid().v4();
      reference.child(extraId);
    }
    try {
      UploadTask uploadTask =
          reference.putFile(image, SettableMetadata(contentType: 'image/jpeg'));

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (err) {
      print("upload task error: ${err.toString()}");
      throw Exception(err.toString());
    }
  }
}
