import 'package:flutter_test/flutter_test.dart';
import 'package:spread/models/artical.dart';

void main() {
  test("test articak model", () {
    Artical artical = Artical(
        articalId: "10",
        title: "test",
        discription: "discription",
        tags: [],
        userId: "10",
        likes: [],
        dislike: [],
        publishedDate: DateTime.now(),
        images: "images",
        weblink: "weblink");
    expect(artical.articalId, "10");
    expect(artical.discription, "discription");
  });
}
