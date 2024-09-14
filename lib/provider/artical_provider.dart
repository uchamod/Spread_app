import 'package:flutter/material.dart';
import 'package:spread/models/artical.dart';

//initial video artical provider
class ArticalProvider extends ChangeNotifier {
  List<Artical> _initialArtical = [];
  List<Artical> initialArticalData = [];

  ArticalProvider() {
    _initialArtical = [
      Artical(
        articalId: 'A001',
        title: 'The Future of Technology',
        discription:
            'Exploring the advancements and innovations in technology.',
        tags: [],
        userId: '001',
        likes: [],
        publishedDate: DateTime(2024, 5, 12),
        images: 'assets/images/future_tech.png',
        weblink: 'https://techfuture.com/future-of-technology',
      ),
      Artical(
        articalId: 'A002',
        title: 'Healthy Living Tips',
        discription: 'A guide to maintaining a healthy lifestyle.',
        tags: [],
        userId: '002',
        likes: [],
        publishedDate: DateTime(2024, 6, 20),
        images: 'assets/images/healthy_living.png',
        weblink: 'https://healthyliving.com/tips',
      ),
      Artical(
        articalId: 'A003',
        title: 'Exploring the Art of Minimalism',
        discription: 'Understanding the principles and benefits of minimalism.',
        tags: [],
        userId: '003',
        likes: [],
        publishedDate: DateTime(2024, 7, 15),
        images: 'assets/images/minimalism_art.png',
        weblink: 'https://lifestyle.com/minimalism',
      ),
      Artical(
        articalId: 'A004',
        title: 'Top Travel Destinations in 2024',
        discription: 'A look at the best places to visit in 2024.',
        tags: [],
        userId: '004',
        likes: [],
        publishedDate: DateTime(2024, 8, 1),
        images: 'assets/images/top_travel.png',
        weblink: 'https://travelguide.com/top-destinations-2024',
      ),
      Artical(
        articalId: 'A005',
        title: 'The Impact of Climate Change',
        discription: 'An in-depth analysis of climate change and its effects.',
        tags: [],
        userId: '005',
        likes: [],
        publishedDate: DateTime(2024, 9, 10),
        images: 'assets/images/climate_change.png',
        weblink: 'https://environmentalnews.com/climate-change-impact',
      ),
    ];
    initialArticalData = List.from(_initialArtical);
  }
}
