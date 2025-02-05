//articals
import 'package:cloud_firestore/cloud_firestore.dart';

class Artical {
  final String articalId;
  final String title;
  final String discription;
  final List tags;
  final String userId;
  final String images;
  final List likes;
  final List dislike;
  final DateTime publishedDate;
  final String? weblink;

  Artical({
    required this.articalId,
    required this.title,
    required this.discription,
    required this.tags,
    required this.userId,
    required this.likes,
    required this.dislike,
    required this.publishedDate,
    required this.images,
    required this.weblink,
  });

  //convert to json object
  Map<String, dynamic> toJson() {
    return {
      "articalId": articalId,
      "title": title,
      "tags": tags,
      "discription": discription,
      "userId": userId,
      "Images": images,
      "likes": likes,
      "dislike": dislike,
      "publishedDate": publishedDate is Timestamp
          ? publishedDate
          : Timestamp.fromDate(publishedDate),
      "weblink": weblink,
    };
  }

//convert from json object
  factory Artical.fromJson(Map<String, dynamic> json) {
    return Artical(
        articalId: json["articalId"],
        title: json["title"],
        tags: json["tags"],
        discription: json["discription"],
        userId: json["userId"],
        images: json["Images"],
        likes: json["likes"],
        dislike: json["dislike"],
        publishedDate: (json["publishedDate"] as Timestamp).toDate(),
        weblink: json["weblink"]);
  }
}
