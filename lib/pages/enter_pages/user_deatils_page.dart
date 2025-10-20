import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spread/notificaion/push_notification.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/services/common_functions.dart';
import 'package:spread/services/firestore.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/reusable_button.dart';
import 'package:spread/widgets/reusable_textformfield.dart';

class UserDeatilsPage extends StatefulWidget {
  final String username;
  final String password;

  const UserDeatilsPage(
      {super.key, required this.username, required this.password});

  @override
  State<UserDeatilsPage> createState() => _UserDeatilsPageState();
}

class _UserDeatilsPageState extends State<UserDeatilsPage> {
  final FirestoreServices _firestoreServices = FirestoreServices();

  //textfield conttrollers
  final TextEditingController _discriptionController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();
  //selected Image
  File? _imagefile;

  //form key
  final _formKey = GlobalKey<FormState>();

  //varibels

  bool isloading = false;
  //select image
  Future<void> imagePicker(ImageSource source) async {
    ImagePicker imgPicker = ImagePicker();
    final image = await imgPicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _imagefile = File(image.path);
      });
    }
  }

  //create new user
  Future<void> createNewUser(
      String username,
      String password,
      File profileImage,
      String discription,
      String location,
      BuildContext context) async {
    setState(() {
      isloading = true;
    });
    try {
      String result = await _firestoreServices.saveNewUser(
          username, password, profileImage, discription, location);
      CommonFunctions()
          .massage(result, Icons.check_circle, Colors.green, context, 2);
      await PushNotification.getFcmToken(
          FirebaseAuth.instance.currentUser!.uid);
    } catch (err) {
      CommonFunctions()
          .massage("Network error", Icons.cancel, errorColor, context);
    }
    setState(() {
      isloading = false;
    });
  }

//dispose user data
  @override
  void dispose() {
    _discriptionController.dispose();
    _locationController.dispose();
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
                //avatar
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: _imagefile != null
                          ? FileImage(_imagefile!)
                          : const AssetImage("assets/avatar2.png"),
                      backgroundColor: secondorywhite.withOpacity(0.3),
                      radius: 65,
                    ),
                    Positioned(
                        bottom: 0,
                        right: -6,
                        child: IconButton(
                          onPressed: () {
                            imagePicker(ImageSource.gallery);
                          },
                          icon: const Icon(
                            CupertinoIcons.camera_circle,
                            color: secondorywhite,
                            size: 40,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                //discription
                ReusableTextformfield(
                  isTagFiled: false,
                  controller: _discriptionController,
                  hint: "Something about yourself...",
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  isShow: false,
                  maxLine: 5,
                  validchecker: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your discription";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: filedpad,
                ),
                //location
                ReusableTextformfield(
                  isTagFiled: false,
                  controller: _locationController,
                  hint: "location",
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.name,
                  isShow: false,
                  maxLine: 1,
                  validchecker: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your location";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                //register button
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await createNewUser(
                          widget.username,
                          widget.password,
                          _imagefile!,
                          _discriptionController.text,
                          _locationController.text,
                          context);
                      GoRouter.of(context).goNamed(RouterNames.home);
                    }
                  },
                  child: ReusableButton(
                    lable: "Sing Up",
                    isLoad: isloading,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),

                //go to login page
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
