import 'package:flutter/material.dart';
import 'package:spread/pages/tabs/miceoblog_add.dart';
import 'package:spread/pages/tabs/video_add.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class AddItems extends StatelessWidget {
  const AddItems({super.key});

  @override
  Widget build(BuildContext context) {
    //add tab bar
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Add Your favourites",
              style: Textstyles().title,
            ),
            bottom: TabBar(
                dividerColor: secondorywhite,
                indicatorColor: primaryYellow,
                labelColor: primaryYellow,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: Textstyles().body,
                unselectedLabelColor: secondorywhite,
                tabs: const [
                  Tab(
                    text: "Blog",
                  ),
                  Tab(
                    text: "Video",
                  ),
                ]),
          ),
          body: const TabBarView(children: [MiceoblogAdd(), VideoAdd()])),
    );
  }
}
