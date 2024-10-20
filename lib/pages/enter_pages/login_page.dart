import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/services/common_functions.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/extralogin.dart';
import 'package:spread/widgets/reusable_button.dart';
import 'package:spread/widgets/reusable_textformfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final AuthServices _authServices = AuthServices();

  final _formKey = GlobalKey<FormState>();

  //varibels
  final double filedpad = 10;
  //load controller
  bool isloading = false;

  //sing in user
  Future<void> singIn(String username, String password) async {
    setState(() {
      isloading = true;
    });
    try {
      await _authServices.singInUser(username, password);
      GoRouter.of(context).goNamed(RouterNames.home);
      CommonFunctions().massage(
          "LogIn Succsussfuly", Icons.check_circle, Colors.green, context);
    } catch (err) {
      CommonFunctions()
          .massage("Attempt Lost", Icons.cancel, errorColor, context);
    }

    setState(() {
      isloading = true;
    });
  }

  //sing in with google
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      // Sign in with Google
      await _authServices.googleSingIn(context);

      GoRouter.of(context).goNamed(RouterNames.home);
    } catch (e) {
      print('Error signing in with Google: $e');
    }
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
                  "assets/Search.svg",
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
                      return "Please enter username";
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: filedpad,
                ),
                //password
                ReusableTextformfield(
                  isTagFiled: false,
                  controller: _passwordController,
                  hint: "password",
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.name,
                  isShow: true,
                  maxLine: 1,
                  validchecker: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }

                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                //sing in button
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      singIn(_nameController.text, _passwordController.text);
                    }
                  },
                  child: ReusableButton(
                    lable: "Sing Up",
                    isLoad: isloading,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                //sing in with google or anonymously
                const Extralogin(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
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
                    //route to auth page
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).goNamed(RouterNames.authPage);
                      },
                      child: Text("Sing Up",
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
