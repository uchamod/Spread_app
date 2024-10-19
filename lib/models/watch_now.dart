import 'package:cloud_firestore/cloud_firestore.dart';

class Videos {
  final String videoId;
  final String title;
  final List tags;
  final String videoUrl;
  final String tubnail;
  final String userId;
  final List likes;
  final List dislike;
  final Timestamp publishedDate;
  final String? weblink;

  Videos(
      {required this.videoId,
      required this.title,
      required this.tags,
      required this.videoUrl,
      required this.tubnail,
      required this.userId,
      required this.likes,
      required this.dislike,
      required this.publishedDate,
      required this.weblink});

  //convert to json object
  Map<String, dynamic> toJson() {
    return {
      "videoId": videoId,
      "title": title,
      "tags": tags,
      "videoUrl": videoUrl,
      "tubnail": tubnail,
      "userId": userId,
      "likes": likes,
      "dislike": dislike,
      "publishedDate": publishedDate
    };
  }

//convert from json object
  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      videoId: json["videoId"],
      title: json["title"],
      tags: json["tags"],
      videoUrl: json["videoUrl"],
      tubnail: json["tubnail"],
      userId: json["userId"],
      likes: json["likes"],
      dislike: json["dislike"],
      publishedDate: json["publishedDate"],
      weblink: json["weblink"],
    );
  }
}
