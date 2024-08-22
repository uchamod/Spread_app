class DirtyMe {
  final String name;
  final String discription;
  final DateTime videoUrl;
  final int audioUrl;
  final String? imagepath;

  DirtyMe(
      {required this.name,
      required this.discription,
      required this.videoUrl,
      required this.audioUrl,
      required this.imagepath});

//   convert to json object
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "discription": discription,
      "videourl": videoUrl,
      "audiourl": audioUrl,
      "imagepath": imagepath,
    };
  }

//convert from json object
  factory DirtyMe.fromJson(Map<String, dynamic> json) {
    return DirtyMe(
      name: json["name"],
      discription: json["discription"],
      videoUrl: json["videourl"],
      audioUrl: json["audiourl"],
      imagepath: json["imagepath"],
    );
  }
}
