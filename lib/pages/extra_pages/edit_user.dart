import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/people.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/services/common_functions.dart';
import 'package:spread/services/firestore.dart';
import 'package:spread/services/storage.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/reusable_button.dart';
import 'package:spread/widgets/reusable_textformfield.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //selected Image
  File? _imagefile;
  bool _isloading = false;
  bool _isImageChanged = false;
  //select image
  Future<void> imagePicker(ImageSource source) async {
    try {
      ImagePicker _imgPicker = ImagePicker();
      final image = await _imgPicker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _imagefile = File(image.path);
          _isImageChanged = true;
        });
      }
    } catch (err) {
      CommonFunctions().massage(
          "Error while Image Picking", Icons.cancel, deleteColor, context, 2);
    }
  }

  //convert String url to File
  File? stringToFile(String imagePath) {
    if (imagePath == null || imagePath.isEmpty) return null;
    return File(imagePath);
  }

  //upload new data
  Future<void> _updateProfile(People user) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isloading = true);

    try {
      String imageToUpload;
      if (_isImageChanged && _imagefile != null) {
        imageToUpload = await StorageServices()
            .uploadImage("ProfilePics", _imagefile!, false);
      } else {
        imageToUpload = user.image;
      }

      await FirestoreServices().updateUser(
        _nameController.text.trim(),
        _passwordController.text.trim(),
        imageToUpload,
        _discriptionController.text.trim(),
        _locationController.text.trim(),
        user.userId,
        user.followers,
        user.followings,
        user.joinedDate,
        context,
      );

      if (mounted) {
        Provider.of<FilterProvider>(context, listen: false).refreshUser();
      }
    } catch (e) {
      print('Failed to update profile: $e');
    } finally {
      if (mounted) {
        setState(() => _isloading = false);
      }
    }
  }

  //reg exp for password
  final RegExp passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{6,}$');

  //reg exp for username
  final RegExp usernameRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  @override
  void dispose() {
    _nameController.dispose();
    _discriptionController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: commonpad, vertical: commonpad),
      child: Form(
        key: _formKey,
        //init provider and set current values
        child: FutureBuilder(
            future: Provider.of<FilterProvider>(context, listen: false)
                .refreshUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: secondorywhite,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: Textstyles().title,
                    ),
                  );
                }
              }

              return Consumer<FilterProvider>(
                builder: (context, currentUser, child) {
                  People user = currentUser.getCurrentUser;
                  _nameController.text = user.name;
                  _discriptionController.text = user.discription;
                  _locationController.text = user.location;
                  _passwordController.text = user.password;

                  return Column(
                    children: [
                      //user profile picture
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: _imagefile != null
                                ? FileImage(_imagefile!)
                                : NetworkImage(user.image),
                            backgroundColor: secondorywhite.withOpacity(0.3),
                            radius: 65,
                          ),
                          //change profile picture
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
                      const SizedBox(
                        height: filedpad,
                      ),
                      //name
                      ReusableTextformfield(
                        controller: _nameController,
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        isShow: false,
                        hint: "Name",
                        maxLine: 1,
                        isTagFiled: false,
                        validchecker: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your discription";
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
                      //discrtiption
                      ReusableTextformfield(
                        controller: _discriptionController,
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        isShow: false,
                        hint: "Discription",
                        maxLine: 2,
                        isTagFiled: false,
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
                        controller: _locationController,
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        isShow: false,
                        hint: "Location",
                        maxLine: 1,
                        isTagFiled: false,
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
                      //password
                      ReusableTextformfield(
                        controller: _passwordController,
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.done,
                        isShow: true,
                        hint: "Password",
                        maxLine: 1,
                        isTagFiled: false,
                        validchecker: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your discription";
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
                      //update data
                      GestureDetector(
                          onTap: () async {
                            _updateProfile(user);
                          },
                          child: ReusableButton(
                              lable: "Update Profile", isLoad: _isloading)),
                    ],
                  );
                },
              );
            }),
      ),
    ));
  }
}
