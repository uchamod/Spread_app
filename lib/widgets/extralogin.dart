import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class Extralogin extends StatelessWidget {
  const Extralogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //continue msg
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Divider(
              color: secondorywhite,
            ),
            Text("Continue with",
                style: Textstyles().body.copyWith(color: primaryYellow)),
            const Divider(
              color: secondorywhite,
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        //login methods
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //google login
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                border: Border.all(color: secondorywhite, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/Google.svg",
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text("Google", style: Textstyles().body),
                ],
              ),
            ),
            const SizedBox(
              width: verPad,
            ),
            //anonymous login
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                border: Border.all(color: secondorywhite, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/incognito.svg",
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text("anonymous", style: Textstyles().body),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
