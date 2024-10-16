import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/people.dart';
import 'package:spread/notificaion/local_notification.dart';
import 'package:spread/pages/extra_pages/edit_profile.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/services/user_services.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/artical_item_card.dart';
import 'package:spread/widgets/video_item_card.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({
    super.key,
    required this.userId,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthServices _authServices = AuthServices();
  bool _isLoading = true;
  bool _hasError = false;
  late Future<People?> _showUser;
  String _inUserId = "";
  int? _followersCount = 0;
  int? _followingCount = 1;
  bool _isFollowing = false;
  @override
  void initState() {
    _showUser = _getUser();
    super.initState();
  }

//get the user details
  Future<People?> _getUser() async {
    try {
      String inUserId = await _authServices.getCurrentUser()!.uid;
      final user = await UserServices().getUserById(widget.userId);
      //user snap
      DocumentSnapshot UserSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userId)
          .get();
      //current user snap
      DocumentSnapshot inUserSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(inUserId)
          .get();
      //user following count
      int? count =
          (UserSnap.data() as Map<String, dynamic>)["following"].length;
      //current user following list
      List followingList =
          (inUserSnap.data() as Map<String, dynamic>)["following"];
      if (followingList.contains(widget.userId)) {
        setState(() {
          _isFollowing = true;
        });
      }
      _followersCount = user!.followers.length;
      _followingCount = count;

      setState(() {
        _inUserId = inUserId;
        _isLoading = false;
        if (user == null) {
          _hasError = true;
        }
      });
      return user;
    } catch (err) {
      setState(() {
        _isLoading = false;

        _hasError = true;
      });
      print("error occurd at _getUserMethod $err");
    }
  }

  void followUser() async {
    await UserServices().followUser(_inUserId, widget.userId, context);
  }

  void editProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EditProfile(),
        ));
  }

  final double widgetHeight = 5;

  get builder => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () {
                _authServices.singOut();
              },
              child: Text(
                "Sing Out",
                style: Textstyles().subtitle.copyWith(color: secondorywhite),
              )),
        ],
      ),
      body: FutureBuilder<People?>(
        future: _showUser,
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_hasError) {
            return const Center(child: Text("Network Error!"));
          }

          if (user == null) {
            return const Center(child: Text("User Not Found"));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: horPad, vertical: verPad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //profile picture
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.image ?? ""),
                    radius: 65,
                  ),
                  SizedBox(
                    height: widgetHeight,
                  ),
                  //username
                  Text(
                    user.name,
                    style: Textstyles().body,
                  ),
                  SizedBox(
                    height: widgetHeight,
                  ),
                  //discription
                  Text(
                    textAlign: TextAlign.center,
                    user.discription,
                    style: Textstyles().label.copyWith(fontSize: 12),
                  ),
                  SizedBox(
                    height: widgetHeight,
                  ),
                  //location
                  Text(
                    user.location,
                    style: Textstyles().label.copyWith(
                        color: secondorywhite.withOpacity(0.5), fontSize: 12),
                  ),
                  SizedBox(
                    height: widgetHeight,
                  ),
                  //followers & followings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //followers
                      Row(
                        children: [
                          Text(
                            _followersCount.toString(),
                            style: Textstyles().body,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Followers",
                            style: Textstyles().body,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      //following
                      Row(
                        children: [
                          Text(
                            _followingCount.toString(),
                            style: Textstyles().body,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Following",
                            style: Textstyles().body,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: verPad,
                  ),
                  //edit or follow
                  _inUserId == widget.userId
                      ? InkWell(
                          onTap: editProfile,
                          child: toggleButton("Edit Profile"))
                      : _isFollowing
                          ? GestureDetector(
                              onTap: () {
                                DateTime scheduleTime = DateTime.now()
                                    .add(const Duration(seconds: 5));
                                followUser();
                                setState(() {
                                  _followersCount = _followersCount! - 1;
                                  _isFollowing = false;
                                });
                                LocalNotification.schedulNotification(
                                    title: "Spread Alert",
                                    body: "Unfollow " + user.name,
                                    schedulTime: scheduleTime);
                                // LocalNotification.instantNotification(
                                //     title: "Spread Alert",
                                //     body: "Unfollow " + user.name);
                              },
                              child: toggleButton("Following"))
                          : GestureDetector(
                              onTap: () {
                                followUser();
                                setState(() {
                                  _followersCount = _followersCount! + 1;
                                  _isFollowing = true;
                                });
                                LocalNotification.instantNotification(
                                    title: "Spread Alert",
                                    body: "You start to follow " + user.name);
                              },
                              child: toggleButton("follow"),
                            ),
                  //user blogs and videos
                  const SizedBox(
                    height: horPad,
                  ),
                  FutureBuilder(
                    future: Provider.of<FilterProvider>(context, listen: false)
                        .setData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text("Server error${snapshot.error}");
                      }
                      //get data from provider
                      return Consumer<FilterProvider>(
                        builder: (context, filterData, child) {
                          filterData.filterByUserId(widget.userId);
                          List<dynamic> selectedData = filterData.userData;
                          selectedData.shuffle();
                          return MasonryGridView.count(
                            crossAxisCount: 2,
                            itemCount: selectedData.length,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return selectedData[index] is Artical
                                  ? ArticalItemCard(
                                      artical: selectedData[index])
                                  : VideoItemCard(video: selectedData[index]);
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //reusable widget
  Widget toggleButton(String name) {
    return Container(
      decoration: BoxDecoration(
          color: primaryYellow, borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.symmetric(horizontal: horPad, vertical: verPad),
      child: Text(
        name,
        style: Textstyles().subtitle.copyWith(color: secondoryBlack),
      ),
    );
  }
}
