import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
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
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: horPad, vertical: verPad),
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
                            const SizedBox(width: 5,)
                          ],
                        )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
