
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class CommonFunctions {
  //function for coustom scafold
   void massage(
      String res, IconData icon, Color iconColor, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          margin:
              const EdgeInsets.only(top: verPad, left: horPad, right: horPad),
          duration: const Duration(seconds: 2),
          dismissDirection: DismissDirection.up,
          backgroundColor: primaryYellow,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                res,
                style: Textstyles().body.copyWith(color: secondoryBlack),
              ),
            ],
          )),
    );
  }
}