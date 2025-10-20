class Comment {
  final String commentId;
  final String comment;
  final String userId;
  final String userProUrl;
  final String userName;
  final String docId;
  final DateTime publishDate;
  final List likes;
  Comment({
    required this.commentId,
    required this.comment,
    required this.userId,
    required this.userProUrl,
    required this.userName,
    required this.docId,
    required this.publishDate,
    required this.likes,
  });

  Map<String, dynamic> toJson() {
    return {
      "commentId": commentId,
      "comment": comment,
      "userId": userId,
      "userProUrl": userProUrl,
      "userName": userName,
      "docId": docId,
      "publishDate": publishDate,
      "likes": likes
    };
  }

//convert from json object
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        commentId: json["commentId"],
        comment: json["comment"],
        userId: json["userId"],
        userProUrl: json["userProUrl"],
        userName: json["userName"],
        docId: json["docId"],
        publishDate: json["publishDate"],
        likes: json["likes"]);
  }
}
