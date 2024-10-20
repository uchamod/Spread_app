import 'package:flutter/material.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class ReusableButton extends StatelessWidget {
  final String lable;
  final bool isLoad;
  const ReusableButton({
    super.key,
    required this.lable,
    required this.isLoad,
  });

  //reusable button
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(commonpad),
        color: primaryYellow,
        boxShadow: [
          BoxShadow(
              color: secondoryBlack.withOpacity(0.2),
              offset: const Offset(1, 4),
              blurRadius: 5)
        ],
      ),
      child: Center(
        child: isLoad
            ? const CircularProgressIndicator(
                color: secondoryBlack,
                strokeWidth: 8,
              )
            : Text(
                lable,
                style: Textstyles().subtitle.copyWith(
                      color: secondoryBlack,
                    ),
              ),
      ),
    );
  }
}
