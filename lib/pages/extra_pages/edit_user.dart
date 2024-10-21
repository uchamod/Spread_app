import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/people.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/services/firestore.dart';
import 'package:spread/util/constants.dart';
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
  bool isloading = false;
  //select image
  Future<void> imagePicker(ImageSource source) async {
    ImagePicker _imgPicker = ImagePicker();
    final image = await _imgPicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _imagefile = File(image.path);
      });
    }
  }

  //convert String url to File
  File stringToFile(String imagePath) {
    return File(imagePath);
  }

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
        child: Consumer<FilterProvider>(
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
                    hint: "",
                    maxLine: 1,
                    isTagFiled: false),
                const SizedBox(
                  height: filedpad,
                ),
                //discrtiption
                ReusableTextformfield(
                    controller: _discriptionController,
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    isShow: false,
                    hint: "",
                    maxLine: 2,
                    isTagFiled: false),
                const SizedBox(
                  height: filedpad,
                ),
                //location
                ReusableTextformfield(
                    controller: _locationController,
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    isShow: false,
                    hint: "",
                    maxLine: 1,
                    isTagFiled: false),
                const SizedBox(
                  height: filedpad,
                ),
                //password
                ReusableTextformfield(
                    controller: _passwordController,
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.done,
                    isShow: true,
                    hint: "",
                    maxLine: 1,
                    isTagFiled: false),
                const SizedBox(
                  height: filedpad,
                ),
                //update data
                GestureDetector(
                    onTap: () async {
                      setState(() {
                        isloading = true;
                      });
                      _imagefile ??= stringToFile(user.image);
                      FirestoreServices().updateUser(
                          _nameController.text,
                          _passwordController.text,
                          _imagefile!,
                          _discriptionController.text,
                          _locationController.text,
                          user.userId,
                          user.followers,
                          user.followings,
                          user.joinedDate,
                          context);
                      setState(() {
                        isloading = false;
                      });
                    },
                    child: ReusableButton(
                        lable: "Update Profile", isLoad: isloading)),
              ],
            );
          },
        ),
      ),
    ));
  }
}
