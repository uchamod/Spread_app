import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        Lottie.asset(
          "assets/Animation - 1725522727636.json",
          animate: true,
        ),
        Text(
          "oops...",
          style: Textstyles().title.copyWith(color: secondoryBlack),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: errorColor,
          ),
          child: Text(
            "Error has occured may be network error or page not found error",
            style: Textstyles().body,
          ),
        )
      ],
    ));
  }
}
