import 'package:flutter/material.dart';
import 'package:spread/pages/tabs/searchItem.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
      
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Search Your favourites",
            style: Textstyles().title.copyWith(color: primaryYellow),
          ),
          //tap bar properties
          bottom: TabBar(
              dividerColor: secondorywhite,
              indicatorColor: primaryYellow,
              labelColor: primaryYellow,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: Textstyles().body,
              unselectedLabelColor: secondorywhite,
              tabs: const [
                Tab(
                  text: "Users",
                ),
                Tab(
                  text: "Micro Blogs",
                ),
                Tab(
                  text: "Videos",
                ),
              ]),
        ),
        body: const TabBarView(children: [
          //user
          Serchitem(
            index: 0,
          ),
          //micro blogs
          Serchitem(
            index: 1,
          ),
          //videos
          Serchitem(
            index: 2,
          )
        ]),
      ),
    );
  }
}
