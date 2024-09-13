//person who use the app
import 'package:cloud_firestore/cloud_firestore.dart';

class People {
  final String userId;
  final String name;
  final String discription;
  final String location;
  final String password;
  final DateTime joinedDate;
  final DateTime updatedDate;
  final String? image;
  final List followers;
  final List followings;

  People({
    required this.userId,
    required this.name,
    required this.discription,
    required this.location,
    required this.password,
    required this.image,
    required this.followers,
    required this.followings,
    required this.joinedDate,
    required this.updatedDate,
  });

//   convert to json object
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "name": name,
      "discription": discription,
      "location": location,
      "password": password,
      "joinedDate": joinedDate,
      "updatedDate": updatedDate,
      "image": image,
      "followers": followers,
      "following": followings
    };
  }

//convert from json object
  factory People.fromJson(Map<String, dynamic> json) {
    return People(
        userId: json["userId"],
        name: json["name"],
        discription: json["discription"] ?? "",
        location: json["location"] ?? "",
        password: json["password"],
        joinedDate: (json["joinedDate"] ?? "" as Timestamp).toDate(),
        updatedDate: (json["updatedDate"] ?? "" as Timestamp).toDate(),
        image: json["image"] ?? "",
        followers: json["followers"] ?? [],
        followings: json["followings"] ?? []);
  }
}
