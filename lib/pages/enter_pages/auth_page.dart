import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/router/route_names.dart';
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

  //regexp for password
  final RegExp passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{6,}$');

  //reg exp for username
  final RegExp usernameRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double topPad = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(horPad, topPad, horPad, 0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
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
                  isTagFiled: false,
                  controller: _nameController,
                  hint: "nickname",
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  isShow: false,
                  maxLine: 1,
                  validchecker: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    if (usernameRegExp.hasMatch(value)) {
                      return "username cannot contain symbols";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: filedpad,
                ),
                //password
                ReusableTextformfield(
                  isTagFiled: false,
                  controller: _passwordController,
                  hint: "password",
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  isShow: true,
                  maxLine: 1,
                  validchecker: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (!passwordRegExp.hasMatch(value)) {
                      return "Invalid password format";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: filedpad,
                ),
                //confirm password
                ReusableTextformfield(
                  isTagFiled: false,
                  controller: _passwordConfirmController,
                  hint: "confirm password",
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.name,
                  isShow: true,
                  maxLine: 1,
                  validchecker: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value != _passwordController.text) {
                      return "Password mismatching";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                //go to user details page
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      GoRouter.of(context).goNamed(RouterNames.userDetailsPage,
                          extra: {
                            "username": _nameController.text,
                            "password": _passwordController.text
                          });
                    }
                  },
                  child: const ReusableButton(
                    lable: "Next",
                    isLoad: false,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                //sing in with google or anonymoulsly
                const Extralogin(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
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
                    //route to login page
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).goNamed(RouterNames.loginPage);
                      },
                      child: Text("Sing In",
                          style:
                              Textstyles().body.copyWith(color: primaryYellow)),
                    ),
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
