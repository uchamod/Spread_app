import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class CommentItem extends StatelessWidget {
  final userSnap;
  const CommentItem({super.key, required this.userSnap});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 75;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horPad, vertical: verPad),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //user avatar
          GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed(RouterNames.profilePage,
                  extra: userSnap["userId"]);
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(userSnap["userProUrl"]),
              radius: 20,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          //comment box
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth,
            ),
            child: Container(
              padding: const EdgeInsets.all(commonpad),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(commonpad),
                color: secondorywhite.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //username

                  Text(
                    textAlign: TextAlign.start,
                    userSnap["userName"],
                    style: Textstyles().body,
                  ),

                  //comment
                  Text(
                    userSnap["comment"],
                    style: Textstyles().subtitle.copyWith(fontSize: 13),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
