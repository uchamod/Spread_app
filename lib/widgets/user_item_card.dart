import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/models/people.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class UserItemCard extends StatelessWidget {
  final People user;
  const UserItemCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .pushNamed(RouterNames.profilePage, extra: user.userId);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(commonpad),
        child: BackdropFilter(
          //add blur effect
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          //people card
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: horPad, vertical: verPad),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //avatar
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.image,
                  ),
                  radius: 60,
                ),
                //username
                Text(
                  user.name,
                  style: Textstyles().subtitle,
                ),
                //discription
                Text(
                  user.discription,
                  style: Textstyles().label,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
