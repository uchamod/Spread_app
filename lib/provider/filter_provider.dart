import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/people.dart';
import 'package:spread/models/watch_now.dart';

class FilterProvider extends ChangeNotifier {
  //data lists
  List<dynamic> _allData = [];
  List<dynamic> _filterdData = [];
  String _selectedCategory = "all";
  List<People> userList = [];
  List<Artical> articalList = [];
  List<Videos> videosList = [];

  //get filterd data
  List<dynamic> get filterData => _filterdData;

  //get & set the data from other providers
  Future<void> setData(BuildContext context) async {
    //ensure build is over
    await Future.delayed(Duration.zero);
    //fetch users data
    QuerySnapshot querySnapshotUser =
        await FirebaseFirestore.instance.collection("users").get();
    userList.clear();
    for (var doc in querySnapshotUser.docs) {
      userList.add(People.fromJson(doc.data() as Map<String, dynamic>));
    }
    //fetch artical data
    QuerySnapshot querySnapshotArtical =
        await FirebaseFirestore.instance.collection("microblogs").get();
    articalList.clear();
    for (var doc in querySnapshotArtical.docs) {
      articalList.add(Artical.fromJson(doc.data() as Map<String, dynamic>));
    }
    //fetch video data
    QuerySnapshot querySnapshotVideo =
        await FirebaseFirestore.instance.collection("videos").get();
    videosList.clear();
    for (var doc in querySnapshotVideo.docs) {
      videosList.add(Videos.fromJson(doc.data() as Map<String, dynamic>));
    }

    //set all data
    _allData = [
      ...articalList,
      ...userList,
      ...videosList,
    ];
    _filterdData = _allData;
    notifyListeners();
  }

  // filter data by selected category
  void filterDataByCategory(String category) {
    _selectedCategory = category;
    if (category == "all") {
      _filterdData = _allData;
    } else if (category == "artical") {
      _filterdData = _allData.whereType<Artical>().toList();
    } else if (category == "videos") {
      _filterdData = _allData.whereType<Videos>().toList();
    } else if (category == "people") {
      _filterdData = _allData.whereType<People>().toList();
    }
    notifyListeners();
  }

  String getCategory() {
    return _selectedCategory;
  }
}
