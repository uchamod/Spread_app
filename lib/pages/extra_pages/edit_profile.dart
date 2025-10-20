import 'package:flutter/material.dart';
import 'package:spread/pages/extra_pages/edit_media.dart';
import 'package:spread/pages/extra_pages/edit_user.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class EditProfile extends StatelessWidget {
  final String userId;
  const EditProfile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              dividerColor: secondorywhite,
              indicatorColor: primaryYellow,
              labelColor: primaryYellow,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: Textstyles().body,
              unselectedLabelColor: secondorywhite,
              tabs: const [
                Tab(
                  text: "Profile",
                ),
                Tab(
                  text: "Media",
                ),
              ]),
        ),
        body: TabBarView(children: [
          //user
         const EditUser(),
          //media
          EditMedia(
            userId: userId,
          ),
        ]),
      ),
    );
  }
}
