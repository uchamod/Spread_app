import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/extralogin.dart';
import 'package:spread/widgets/reusable_button.dart';
import 'package:spread/widgets/reusable_textformfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  //varibels
  final double filedpad = 12;
  @override
  Widget build(BuildContext context) {
    final double topPad = MediaQuery.of(context).size.height * 0.15;
    return Container(
      padding: EdgeInsets.only(left: horPad, right: horPad, top: topPad),
      decoration: const BoxDecoration(
        //add greadient background
        gradient: LinearGradient(
            colors: [backgroundBlue, backgroundPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //sticker
                SvgPicture.asset(
                  "assets/adult/Spread.svg",
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                //username
                ReusableTextformfield(
                  controller: _nameController,
                  hint: "nickname",
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  isShow: false,
                  maxLine: 1,
                ),
                SizedBox(
                  height: filedpad,
                ),
                //password
                ReusableTextformfield(
                  controller: _passwordController,
                  hint: "password",
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.name,
                  isShow: true,
                  maxLine: 1,
                ),
                SizedBox(
                  height: filedpad,
                ),
                //confirm password

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
             const ReusableButton(lable: "Sing Up",routeName: RouterNames.home,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const Extralogin(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't you have an account?",
                      style: Textstyles().body,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text("Sing In",
                        style:
                            Textstyles().body.copyWith(color: primaryYellow)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
