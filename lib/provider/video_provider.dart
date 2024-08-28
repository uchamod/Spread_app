import 'package:flutter/material.dart';
import 'package:spread/models/watch_now.dart';

//initial video data provider
class VideoProvider extends ChangeNotifier {
  List<Videos> _initialVideos = [];
  List<Videos> initialvideosData = [];

  VideoProvider() {
    _initialVideos = [
      Videos(
        videoId: 'V001',
        title: 'Understanding Flutter',
        tags: ['Flutter', 'Development', 'Tutorial'],
        videoUrl: 'https://example.com/flutter_video',
        tubnail: 'assets/images/flutter_thumbnail.png',
        userId: '001',
        likes: [],
        publishedDate: DateTime(2024, 2, 15),
        weblink: 'https://example.com/flutter',
      ),
      Videos(
        videoId: 'V002',
        title: 'Yoga for Beginners',
        tags: ['Yoga', 'Health', 'Wellness'],
        videoUrl: 'https://example.com/yoga_video',
        tubnail: 'assets/images/yoga_thumbnail.png',
        userId: '002',
        likes: [],
        publishedDate: DateTime(2024, 3, 10),
        weblink: 'https://example.com/yoga',
      ),
      Videos(
        videoId: 'V003',
        title: 'Top 10 Travel Destinations',
        tags: ['Travel', 'Adventure', 'Tourism'],
        videoUrl: 'https://example.com/travel_video',
        tubnail: 'assets/images/travel_thumbnail.png',
        userId: '003',
        likes: [],
        publishedDate: DateTime(2024, 4, 20),
        weblink: 'https://example.com/travel',
      ),
      Videos(
        videoId: 'V004',
        title: 'Cooking with Kids',
        tags: ['Cooking', 'Family', 'Kids'],
        videoUrl: 'https://example.com/cooking_video',
        tubnail: 'assets/images/cooking_thumbnail.png',
        userId: '004',
        likes: [],
        publishedDate: DateTime(2024, 5, 5),
        weblink: 'https://example.com/cooking',
      ),
      Videos(
        videoId: 'V005',
        title: 'Introduction to Machine Learning',
        tags: ['Machine Learning', 'AI', 'Data Science'],
        videoUrl: 'https://example.com/ml_video',
        tubnail: 'assets/images/ml_thumbnail.png',
        userId: '005',
        likes: [],
        publishedDate: DateTime(2024, 6, 1),
        weblink: 'https://example.com/ml',
      ),
    ];
    initialvideosData = List.from(_initialVideos);
  }
}
