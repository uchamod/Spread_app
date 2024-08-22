class Habbits {
  final String category;
  final String name;
  final String discription;
  final DateTime datetime;
  final int duration;

  Habbits(
      {required this.category,
      required this.name,
      required this.discription,
      required this.datetime,
      required this.duration});
  //convert to json object
  Map<String, dynamic> toJson() {
    return {
      "category": category,
      "name": name,
      "discription": discription,
      "datetime": datetime,
      "duration": duration
    };
  }

//convert from json object
  factory Habbits.fromJson(Map<String, dynamic> json) {
    return Habbits(
      category: json["category"],
      name: json["name"],
      discription: json["discription"],
      datetime: json["datetime"],
      duration: json["duration"],
    );
  }
}
