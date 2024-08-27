//articals
class Artical {
  final String articalId;
  final String title;
  final String discription;
  final String category;
  final String userId;
  final List? images;
  final dynamic likes;
  final DateTime publishedDate;
  final String? weblink;

  Artical({
    required this.articalId,
    required this.title,
    required this.discription,
    required this.category,
    required this.userId,
    required this.likes,
    required this.publishedDate,
    required this.images,
    required this.weblink,
  });

  //convert to json object
  Map<String, dynamic> toJson() {
    return {
      "articalId": articalId,
      "title": title,
      "category": category,
      "discription": discription,
      "userId": userId,
      "Images": images,
      "likes": likes,
      "publishedDate": publishedDate,
      "weblink": weblink,
    };
  }

//convert from json object
  factory Artical.fromJson(Map<String, dynamic> json) {
    return Artical(
        articalId: json["articalId"],
        title: json["title"],
        category: json["category"],
        discription: json["discription"],
        userId: json["userId"],
        images: json["Images"],
        likes: json["likes"],
        publishedDate: json["publishedDate"],
        weblink: json["weblink"]);
  }
}
