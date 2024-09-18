import 'package:flutter/material.dart';
import 'package:spread/models/people.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/services/user_services.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

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

  final double widgetHeight = 5;
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
                            user.followers.length.toString(),
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
                            user.followings.length.toString(),
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryYellow,
                          borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: horPad, vertical: verPad),
                      child: Text(
                        _inUserId == widget.userId ? "Edit Profile" : "Follow",
                        style: Textstyles()
                            .subtitle
                            .copyWith(color: secondoryBlack),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
