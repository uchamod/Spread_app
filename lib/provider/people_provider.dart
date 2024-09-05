import 'package:flutter/material.dart';
import 'package:spread/models/people.dart';

//initial users data provider
class PeopleProvider extends ChangeNotifier {
  List<People> _initialPeople = [];
  List<People> initialPeopleData = [];

  PeopleProvider() {
    _initialPeople = [
      People(
        userId: '001',
        name: 'John Doe',
        discription: 'Loves hiking and outdoor adventures.',
        location: 'New York, USA',
        password: 'password123',
        image: 'assets/images/john_doe.png',
        followers: [],
        followings: [],
        joinedDate: DateTime.now(),
        updatedDate: DateTime.now(),
      ),
      People(
        userId: '002',
        name: 'Jane Smith',
        discription: 'Passionate about technology and coding.',
        location: 'San Francisco, USA',
        password: 'qwerty456',
        image: 'assets/images/jane_smith.png',
        followers: [],
        followings: [],
        joinedDate: DateTime.now(),
        updatedDate: DateTime.now(),
      ),
      People(
        userId: '003',
        name: 'Emily Johnson',
        discription: 'Avid reader and aspiring author.',
        location: 'London, UK',
        password: 'emily789',
        image: 'assets/images/emily_johnson.png',
        followers: [],
        followings: [],
        joinedDate: DateTime.now(),
        updatedDate: DateTime.now(),
      ),
      People(
        userId: '004',
        name: 'Michael Brown',
        discription: 'Fitness enthusiast and personal trainer.',
        location: 'Sydney, Australia',
        password: 'fitlife101',
        image: 'assets/images/michael_brown.png',
        followers: [],
        followings: [],
        joinedDate: DateTime.now(),
        updatedDate: DateTime.now(),
      ),
      People(
        userId: '005',
        name: 'Sophia Davis',
        discription: 'Art lover and painter.',
        location: 'Paris, France',
        password: 'artlover2021',
        image: 'assets/images/sophia_davis.png',
        followers: [],
        followings: [],
        joinedDate: DateTime.now(),
        updatedDate: DateTime.now(),
      ),
    ];
    initialPeopleData = List.from(_initialPeople);
  }
}
