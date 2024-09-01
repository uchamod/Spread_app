import 'package:flutter/material.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class ReusableTextformfield extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isShow;
  final String hint;
  const ReusableTextformfield(
      {super.key,
      required this.controller,
      required this.inputType,
      required this.inputAction,
      required this.isShow,
      required this.hint});

  @override
  State<ReusableTextformfield> createState() => _ReusableTextformfieldState();
}

class _ReusableTextformfieldState extends State<ReusableTextformfield> {
  @override
  Widget build(BuildContext context) {
    //formfield
    return TextFormField(
      cursorColor: secondorywhite,
      controller: widget.controller,
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      obscureText: widget.isShow,
      style: Textstyles().body.copyWith(fontSize: 16),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: horPad, vertical: 15),
        hintText: widget.hint,
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
