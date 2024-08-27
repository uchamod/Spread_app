import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class ItemShowCard extends StatelessWidget {
  const ItemShowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //add blury backdrop
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              //coustom card
              child: Container(
                padding:  const EdgeInsets.symmetric(
                    horizontal: horPad, vertical: verPad),
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
                  children: [
                    Text(
                      "Title",
                      style: Texystyles().title,
                    ),
                    Text(
                      "Sub Title",
                      style: Texystyles().subtitle,
                    ),
                    Text(
                      "Instead, it is away of specifying functions of the physical layer and the data link layer of major LAN protocols.",
                      style: Texystyles().body,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
