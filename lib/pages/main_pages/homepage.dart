import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/provider/filter_provider.dart';
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
      backgroundColor: Colors.transparent,
      body: SafeArea(
        //get data from future builder
        child: FutureBuilder(
          future: Provider.of<FilterProvider>(context, listen: false)
              .setData(context),
          builder: (context, snapshot) {
            //check state and provide context
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
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
                return Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.30,
                      left: 22,
                      child: Image.asset(
                        "assets/adult/crown.png",
                        scale: 1.15,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: double.maxFinite,
                        padding: const EdgeInsets.symmetric(horizontal: horPad),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //add logo
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                "assets/adult/Spread.svg",
                                height: 35,
                              ),
                            ),
                            //filter chips

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  //all
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      backgroundColor: backgroundBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              filterborder)),
                                      side: const BorderSide(
                                          color: secondorywhite, width: 2),
                                      label: Text(
                                        "All",
                                        style: Textstyles().subtitle,
                                      ),
                                      selectedColor: backgroundPurple,
                                      showCheckmark: false,
                                      selected:
                                          filterData.getCategory() == "all",

                                      //show all items
                                      onSelected: (value) {
                                        filterData.filterDataByCategory("all");
                                      },
                                    ),
                                  ),
                                  //articals
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      backgroundColor: backgroundBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              filterborder)),
                                      side: const BorderSide(
                                          color: secondorywhite, width: 2),
                                      label: Text(
                                        "Artical",
                                        style: Textstyles().subtitle,
                                      ),
                                      selectedColor: backgroundPurple,
                                      showCheckmark: false,
                                      selected:
                                          filterData.getCategory() == "artical",
                                      //ahow articals
                                      onSelected: (value) {
                                        filterData
                                            .filterDataByCategory("artical");
                                      },
                                    ),
                                  ),
                                  //videos
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      backgroundColor: backgroundBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              filterborder)),
                                      side: const BorderSide(
                                          color: secondorywhite, width: 2),
                                      label: Text(
                                        "Watch Now",
                                        style: Textstyles().subtitle,
                                      ),
                                      selectedColor: backgroundPurple,
                                      showCheckmark: false,
                                      selected:
                                          filterData.getCategory() == "videos",
                                      //show videos
                                      onSelected: (value) {
                                        filterData
                                            .filterDataByCategory("videos");
                                      },
                                    ),
                                  ),
                                  //people
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      backgroundColor: backgroundBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              filterborder)),
                                      side: const BorderSide(
                                          color: secondorywhite, width: 2),
                                      label: Text(
                                        "People",
                                        style: Textstyles().subtitle,
                                      ),
                                      selectedColor: backgroundPurple,
                                      showCheckmark: false,
                                      selected:
                                          filterData.getCategory() == "people",
                                      onSelected: (value) {
                                        filterData
                                            .filterDataByCategory("people");
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
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                axisDirection: AxisDirection.down,
                                children: selectedData.map((item) {
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
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
