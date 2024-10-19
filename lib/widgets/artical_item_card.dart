import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class ArticalItemCard extends StatelessWidget {
  final Artical artical;
  const ArticalItemCard({super.key, required this.artical});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(RouterNames.singleArticalPage,extra: artical);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(commonpad),
        child: BackdropFilter(
          //add blur effect
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          //artical card
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(commonpad),
              color: secondoryBlack,
              border: Border.all(color: secondorywhite,width: 0.5),
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
                  //artical image
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: Image.network(
                      artical.images,
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
                        artical.title,
                        style: Textstyles().subtitle,
                      ),
                      Text(
                        artical.discription,
                        style: Textstyles().label,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
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
