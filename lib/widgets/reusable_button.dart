import 'package:flutter/material.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class ReusableButton extends StatelessWidget {
  final String lable;
  const ReusableButton({super.key, required this.lable});
  //reusable button
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: primaryYellow,
        boxShadow: [
          BoxShadow(
              color: secondoryBlack.withOpacity(0.2),
              offset: const Offset(1, 4),
              blurRadius: 5)
        ],
      ),
      child: Center(
        child: Text(
          lable,
          style:
              Textstyles().title.copyWith(color: secondoryBlack, fontSize: 24),
        ),
      ),
    );
  }
}
