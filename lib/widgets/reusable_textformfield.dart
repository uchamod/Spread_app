import 'package:flutter/material.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class ReusableTextformfield extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isShow;
  final String hint;
  final int maxLine;
  final String? Function(String?)? validchecker;
  const ReusableTextformfield(
      {super.key,
      required this.controller,
      required this.inputType,
      required this.inputAction,
      required this.isShow,
      required this.hint, required this.maxLine, this.validchecker});

  @override
  Widget build(BuildContext context) {
    //formfield
    return TextFormField(
      validator: validchecker,
      maxLines:maxLine ,
      cursorColor: secondorywhite,
      controller: controller,
      textInputAction: inputAction,
      keyboardType: inputType,
      obscureText: isShow,
      style: Textstyles().body.copyWith(fontSize: 16),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: horPad, vertical: 15),
        hintText: hint,
        hintStyle:
            Textstyles().body.copyWith(color: secondorywhite.withOpacity(0.6)),
        border: formFieldBorder(secondorywhite),
        focusedBorder: formFieldBorder(secondorywhite),
        errorBorder: formFieldBorder(errorColor),
        enabledBorder: formFieldBorder(secondorywhite),
      ),
    );
  }

//border style
  OutlineInputBorder formFieldBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderColor,
        width: 2,
      ),
    );
  }
}
