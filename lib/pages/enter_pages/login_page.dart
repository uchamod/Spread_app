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
  final double filedpad = 12;
  //load controller
  bool isloading = false;

  //sing in user
  Future<void> singIn(String username, String password) async {
    setState(() {
      isloading = true;
    });
    try {
      await _authServices.singInUser(username, password);
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
                  controller: _passwordController,
                  hint: "password",
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.name,
                  isShow: true,
                  maxLine: 1,
                  validchecker: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: filedpad,
                ),
                //confirm password

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                //sing in with google or anonymously
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
