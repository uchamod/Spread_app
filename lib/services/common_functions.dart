import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:timezone/timezone.dart' as tz;

class CommonFunctions {
  //function for coustom scafold
  void massage(
      String res, IconData icon, Color iconColor, BuildContext context,int duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          margin:
              const EdgeInsets.only(top: verPad, left: horPad, right: horPad),
          duration:  Duration(seconds: duration),
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

  //recurrsive time scheduler
  tz.TZDateTime toNextTimeSchedule(DateTime time, Day day) {
    //get current time
    final tz.TZDateTime currentTime = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, currentTime.year,
        currentTime.month, currentTime.day, time.hour, time.minute);

    if (scheduledDate.isBefore(currentTime)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
