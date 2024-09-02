import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/extralogin.dart';
import 'package:spread/widgets/reusable_button.dart';
import 'package:spread/widgets/reusable_textformfield.dart';

class UserDeatilsPage extends StatelessWidget {
  UserDeatilsPage({super.key});
  final TextEditingController _discriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  //form key
  final _formKey = GlobalKey<FormState>();
  //varibels
  final double filedpad = 12;

  @override
  Widget build(BuildContext context) {
    final double topPad = MediaQuery.of(context).size.height * 0.10;
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
                //avatar
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: secondorywhite.withOpacity(0.3),
                      radius: 65,
                    ),
                    const Positioned(
                        bottom: 0,
                        right: 8,
                        child: Icon(
                          CupertinoIcons.camera_circle,
                          color: secondorywhite,
                          size: 40,
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                //discription
                ReusableTextformfield(
                  controller: _discriptionController,
                  hint: "Something about you...",
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  isShow: false,
                  maxLine: 4,
                ),
                SizedBox(
                  height: filedpad,
                ),
                //location
                ReusableTextformfield(
                  controller: _locationController,
                  hint: "location",
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.name,
                  isShow: true,
                  maxLine: 1,
                ),
                SizedBox(
                  height: filedpad,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const ReusableButton(
                  lable: "Sing In",
                  routeName: RouterNames.home,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const Extralogin(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
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
