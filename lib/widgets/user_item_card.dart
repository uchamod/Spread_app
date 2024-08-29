import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spread/models/people.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class UserItemCard extends StatelessWidget {
  final People user;
  const UserItemCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(    //add blur effect
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        //people card
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: horPad, vertical: verPad),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/DUA LIPA x ROLLING STONE - FEBRUARY 2024.jpg"),
                radius: 60,
              ),
              Text(
                user.name,
                style: Textstyles().title,
              ),
              Text(
                user.discription,
                style: Textstyles().body,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
