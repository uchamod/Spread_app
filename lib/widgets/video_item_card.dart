import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class VideoItemCard extends StatelessWidget {
  final Videos video;
  const VideoItemCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .pushNamed(RouterNames.singleVideoPage, extra: video);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(commonpad),
        child: BackdropFilter(
          //add blur effeect
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          //coustom video card
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(commonpad),
              color: secondoryBlack,
              border: Border.all(color: secondorywhite, width: 0.5),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(2, 3),
                  blurRadius: 6,
                  color: const Color(000000).withOpacity(
                    0.18,
                  ),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(commonpad),
                      topRight: Radius.circular(commonpad)),
                  //thubnail
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      video.tubnail,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: horPad, vertical: verPad),
                  child: Column(
                    children: [
                      Text(
                        video.title,
                        style: Textstyles().subtitle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
