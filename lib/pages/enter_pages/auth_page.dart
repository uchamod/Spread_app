import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/extralogin.dart';
import 'package:spread/widgets/reusable_button.dart';
import 'package:spread/widgets/reusable_textformfield.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //form field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  //form key
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
                ),
                SizedBox(
                  height: filedpad,
                ),
                //password
                ReusableTextformfield(
                  controller: _passwordController,
                  hint: "password",
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  isShow: true,
                ),
                SizedBox(
                  height: filedpad,
                ),
                //confirm password
                ReusableTextformfield(
                  controller: _passwordConfirmController,
                  hint: "confirm password",
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.name,
                  isShow: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const ReusableButton(lable: "Next"),
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
                      "Already have an account?",
                      style: Textstyles().body,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text("Sing Up",
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
