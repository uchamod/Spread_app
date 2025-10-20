import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/artical_item_card.dart';
import 'package:spread/widgets/user_item_card.dart';
import 'package:spread/widgets/video_item_card.dart';

//homepage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        //get data from future builder
        child: FutureBuilder(
          future: Provider.of<FilterProvider>(context, listen: false)
              .setData(context),
          builder: (context, snapshot) {
            //check state and provide context
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: secondorywhite,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: Textstyles().title,
                ),
              );
            }
            //consume and show data
            return Consumer<FilterProvider>(
              builder: (context, filterData, child) {
                final selectedData = filterData.filterData;
                selectedData.shuffle();
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: horPad),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //add logo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                "assets/Frame 1.svg",
                                height: 65,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  GoRouter.of(context).go(RouterNames.home);
                                },
                                icon: const Icon(
                                  Icons.notifications,
                                  size: 24,
                                  color: primaryYellow,
                                )),
                          ],
                        ),
                        //filter chips

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              //all
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: FilterChip(
                                  backgroundColor:
                                      secondorywhite.withOpacity(0.15),

                                  label: Text(
                                    "All",
                                    style: filterData.getCategory() == "all"
                                        ? Textstyles()
                                            .body
                                            .copyWith(color: secondoryBlack)
                                        : Textstyles().body,
                                  ),
                                  selectedColor: secondorywhite,
                                  showCheckmark: false,
                                  selected: filterData.getCategory() == "all",
                                  side: BorderSide.none,

                                  //show all items
                                  onSelected: (value) {
                                    filterData.filterDataByCategory("all");
                                  },
                                ),
                              ),
                              //articals
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: FilterChip(
                                  backgroundColor:
                                      secondorywhite.withOpacity(0.15),
                                  side: BorderSide.none,
                                  label: Text(
                                    "Artical",
                                    style: filterData.getCategory() == "artical"
                                        ? Textstyles()
                                            .body
                                            .copyWith(color: secondoryBlack)
                                        : Textstyles().body,
                                  ),
                                  selectedColor: secondorywhite,
                                  showCheckmark: false,
                                  selected:
                                      filterData.getCategory() == "artical",
                                  //ahow articals
                                  onSelected: (value) {
                                    filterData.filterDataByCategory("artical");
                                  },
                                ),
                              ),
                              //videos
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: FilterChip(
                                  backgroundColor:
                                      secondorywhite.withOpacity(0.15),
                                  side: BorderSide.none,
                                  label: Text(
                                    "Videos",
                                    style: filterData.getCategory() == "videos"
                                        ? Textstyles()
                                            .body
                                            .copyWith(color: secondoryBlack)
                                        : Textstyles().body,
                                  ),
                                  selectedColor: secondorywhite,
                                  showCheckmark: false,
                                  selected:
                                      filterData.getCategory() == "videos",
                                  //show videos
                                  onSelected: (value) {
                                    filterData.filterDataByCategory("videos");
                                  },
                                ),
                              ),
                              //people
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: FilterChip(
                                  backgroundColor:
                                      secondorywhite.withOpacity(0.15),
                                  side: BorderSide.none,
                                  label: Text(
                                    "Chanels",
                                    style: filterData.getCategory() == "people"
                                        ? Textstyles()
                                            .body
                                            .copyWith(color: secondoryBlack)
                                        : Textstyles().body,
                                  ),
                                  selectedColor: secondorywhite,
                                  showCheckmark: false,
                                  selected:
                                      filterData.getCategory() == "people",
                                  onSelected: (value) {
                                    filterData.filterDataByCategory("people");
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        //item grid view
                        if (selectedData.isNotEmpty)
                          StaggeredGrid.count(
                            crossAxisCount:
                                filterData.getCategory() == "videos" ? 1 : 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            axisDirection: AxisDirection.down,
                            children: selectedData.map((item) {
                              //item
                              return GestureDetector(
                                onTap: () {},
                                child: item is Artical
                                    ? ArticalItemCard(artical: item)
                                    : item is Videos
                                        ? VideoItemCard(video: item)
                                        : UserItemCard(user: item),
                              );
                            }).toList(),
                          )
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "No data found",
                                  style: Textstyles().body,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
