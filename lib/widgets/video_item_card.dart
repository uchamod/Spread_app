import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class VideoItemCard extends StatelessWidget {
  final Videos video;
  const VideoItemCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        //add blur effeect
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        //coustom video card
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: cardColor,
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
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                child: Image.asset(
                  "assets/Untitled design.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: horPad, vertical: verPad),
                child: Column(
                  children: [
                    Text(
                      video.title,
                      style: Textstyles().title,
                    ),
                    Text(
                      video.publishedDate.toString(),
                      style: Textstyles().body,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
