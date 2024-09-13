import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spread/models/people.dart';

class UserServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //get user by user id
  Future<People?> getUserById(String id) async {
    try {
      final userDocument =
          await _firebaseFirestore.collection("users").doc(id).get();
      if (userDocument.exists) {
        return People.fromJson(userDocument.data() as Map<String,dynamic>);
      }
    } catch (err) {
      print("error from getUserById method $err");
      return null;
    }
  }
}
