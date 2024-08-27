//person who use the app
class People {
  final String userId;
  final String name;
  final String discription;
  final String location;
  final String password;
  final String? image;
  final List followers;
  final List followings;
  People(
      {required this.userId,
      required this.name,
      required this.discription,
      required this.location,
      required this.password,
      required this.image,
      required this.followers,
      required this.followings});

//   convert to json object
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "name": name,
      "discription": discription,
      "location": location,
      "password": password,
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
        discription: json["discription"],
        location: json["location"],
        password: json["password"],
        image: json["image"],
        followers: json["followers"],
        followings: json["followings"]);
  }
}
