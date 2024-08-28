import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/people.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/provider/artical_provider.dart';
import 'package:spread/provider/people_provider.dart';
import 'package:spread/provider/video_provider.dart';

class FilterProvider extends ChangeNotifier {
  //data lists
  List<dynamic> _allData = [];
  List<dynamic> _filterdData = [];
  String selectedCategory = "all";
  //get filterd data
  List<dynamic> get filterData => _filterdData;

  //get & set the data from other providers
  Future<void> setData(BuildContext context) async {
    //ensure build is over
    await Future.delayed(Duration.zero);

    final List<Artical> articalList =
        Provider.of<ArticalProvider>(context, listen: false).initialArticalData;
    final List<Videos> videoList =
        Provider.of<VideoProvider>(context, listen: false).initialvideosData;
    final List<People> peopleList =
        Provider.of<PeopleProvider>(context, listen: false).initialPeopleData;
    //set all data
    _allData = [
      ...articalList,
      ...peopleList,
      ...videoList,
    ];
    _filterdData = _allData;
    notifyListeners();
  }

  //filter data by selected category
  void filterDataByCategory(String category) {
    selectedCategory = category;
    if (category == "all") {
      _filterdData = _allData;
    } else if (category == "artical") {
      _filterdData = _allData.whereType<Artical>().toList();
    } else if (category == "videos") {
      _filterdData = _allData.whereType<Videos>().toList();
    } else {
      _filterdData = _allData.whereType<People>().toList();
    }
    notifyListeners();
  }
}
