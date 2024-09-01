import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/reusable_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});
//intro page
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: horPad, vertical: verPad),
      decoration: const BoxDecoration(
        //add greadient background
        gradient: LinearGradient(
            colors: [backgroundBlue, backgroundPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            //sticker
            SvgPicture.asset(
              "assets/intro.svg",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            //warning massage
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: horPad, vertical: verPad),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: secondorywhite,
                    width: 2,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "WARNING",
                    style: Textstyles()
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "This application may contain material intended for mature audiences, including explicit language, sexual content, violence, and substance use. Users must be 18 years or older to access this content. By proceeding, you confirm that you are of legal age and consent to viewing such material. Parental discretion is strongly advised.",
                    style:
                        Textstyles().body.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            //button to sing up page 1
            const ReusableButton(lable: "Next"),
          ],
        ),
      ),
    );
  }
}
