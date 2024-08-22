class WatchNow {
  final String category;
  final String name;
  final String webUrl;
  final String imagePath;
  final int duration;

  WatchNow(
      {required this.category,
      required this.name,
      required this.imagePath,
      required this.webUrl,
      required this.duration});
  //convert to json object
  Map<String, dynamic> toJson() {
    return {
      "category": category,
      "name": name,
      "weburl": webUrl,
      "imagepath": imagePath,
      "duration": duration
    };
  }

//convert from json object
  factory WatchNow.fromJson(Map<String, dynamic> json) {
    return WatchNow(
      category: json["category"],
      name: json["name"],
      webUrl: json["weburl"],
      imagePath: json["imagepath"],
      duration: json["duration"],
    );
  }
}
