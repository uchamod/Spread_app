import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class DetaildVideoItemCard extends StatelessWidget {
  final Videos video;
  final String username;
  const DetaildVideoItemCard(
      {super.key, required this.video, required this.username});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .pushNamed(RouterNames.singleVideoPage, extra: video);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: secondoryBlack,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                video.tubnail,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: horPad, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text(
                    video.title,
                    style: Textstyles().body,
                  ),
                  //other details
                  Row(
                    children: [
                      Text(
                        username,
                        style: Textstyles().label.copyWith(
                            fontSize: 12,
                            color: secondorywhite.withOpacity(0.5)),
                      ),
                      const SizedBox(
                        width: horPad,
                      ),
                      Icon(
                        Icons.thumb_up_alt_rounded,
                        color: secondorywhite.withOpacity(0.5),
                        size: 12,
                      ),
                      Text(
                        " " + video.likes.length.toString(),
                        style: Textstyles().label.copyWith(
                            fontSize: 12,
                            color: secondorywhite.withOpacity(0.5)),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
