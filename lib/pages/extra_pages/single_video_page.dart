import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/video_item_card.dart';
import 'package:spread/widgets/video_player.dart';

class SingleVideoPage extends StatelessWidget {
  final Videos video;
  const SingleVideoPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [backgroundBlue, backgroundPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          //back to home
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).goNamed(RouterNames.home);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: secondorywhite,
                size: 25,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horPad, vertical: verPad),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //video
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CoustomVideoPlayer(videoUrl: video.videoUrl),
                    ),
                    const SizedBox(
                      height: verPad,
                    ),
                    //title
                    Text(
                      video.title,
                      style: Textstyles().title,
                    ),
                    const SizedBox(
                      height: verPad,
                    ),
                    //tags
                    Row(
                      children: [
                        for (int i = 0; i < video.tags.length; i++)
                          Wrap(
                            children: [
                              Text(
                                video.tags[i],
                                style: Textstyles().label,
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                          )
                      ],
                    ),
                    const SizedBox(
                      height: verPad,
                    ),
                    //other videos
                    FutureBuilder(
                      future:
                          Provider.of<FilterProvider>(context, listen: false)
                              .setData(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: secondorywhite,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            "Network Error",
                            style: Textstyles().body,
                          ));
                        }
                        return Consumer<FilterProvider>(
                          builder: (context, filterdata, child) {
                            List<Videos> videoData = filterdata.filterData
                                .whereType<Videos>()
                                .toList();
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1, mainAxisSpacing: 15),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              //todo : check lenth in future
                              itemCount: videoData.length - 1,
                              itemBuilder: (context, index) {
                                if (videoData[index].videoId != video.videoId) {
                                  return VideoItemCard(video: videoData[index]);
                                }
                              },
                            );
                          },
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
