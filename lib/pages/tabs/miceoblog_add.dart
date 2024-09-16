import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/services/firestore.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/reusable_button.dart';
import 'package:spread/widgets/reusable_textformfield.dart';

class MiceoblogAdd extends StatefulWidget {
  const MiceoblogAdd({super.key});

  @override
  State<MiceoblogAdd> createState() => _MiceoblogAddState();
}

class _MiceoblogAddState extends State<MiceoblogAdd> {
  //controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final FirestoreServices _firestoreServices = FirestoreServices();
  //form key
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _image;
  //tag list
  List<String> _tags = [];
  //pick a image
  Future<void> imagePicker(ImageSource source) async {
    ImagePicker _imgPicker = ImagePicker();
    final image = await _imgPicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  //upload microblog post
  Future<void> _uploadBlog(String title, String content, File image,
      List<String> tags, String url) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _firestoreServices.addBlog(
          title, content, image, tags, url, context);
      setState(() {
        _isLoading = false;
        GoRouter.of(context).goNamed(RouterNames.home);
      });
    } catch (err) {
      print("something went wrong");
    }
  }
  //add tags

  void _addTag(String tag) {
    setState(() {
      if (tag.isNotEmpty && !_tags.contains(tag)) {
        _tags.add(tag);
      }
    });
    _tagsController.clear();
  }

//dispost controllers
  @override
  void dispose() {
    _contentController.dispose();
    _linkController.dispose();
    _tagsController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //microblog tab
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            left: horPad, right: horPad, top: 15, bottom: 100),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //title
              ReusableTextformfield(
                isTagFiled: false,
                controller: _titleController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                isShow: false,
                hint: "Title",
                maxLine: 2,
                validchecker: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the tilte";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: verPad,
              ),
              //image
              GestureDetector(
                onTap: () {
                  imagePicker(ImageSource.gallery);
                },
                child: _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.fitWidth,
                      )
                    : Image.asset(
                        "assets/tubnail.png",
                        fit: BoxFit.fitWidth,
                      ),
              ),
              const SizedBox(
                height: verPad,
              ),
              //content
              ReusableTextformfield(
                isTagFiled: false,
                controller: _contentController,
                inputType: TextInputType.multiline,
                inputAction: TextInputAction.next,
                isShow: false,
                hint: "Content",
                maxLine: null,
                validchecker: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the content";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: verPad,
              ),
              //tags
              ReusableTextformfield(
                isTagFiled: true,
                controller: _tagsController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                isShow: false,
                hint: "Tag",
                maxLine: 1,
                validchecker: (value) {
                  if (_tags.isEmpty) {
                    return "Please enter the at least 1 tag";
                  }
                  return null;
                },
                addTag: () {
                  _addTag(_tagsController.text);
                },
              ),

              //show tags
              Wrap(
                spacing: 8.0,
                children: _tags.map((tag) {
                  return Chip(
                    side: BorderSide.none,
                    label: Text(
                      tag,
                      style: Textstyles().label.copyWith(color: secondoryBlack),
                    ),
                    backgroundColor: secondorywhite,
                    deleteIcon: const Icon(
                      Icons.close,
                      color: secondoryBlack,
                      grade: 15,
                    ),
                    onDeleted: () {
                      setState(() {
                        _tags.remove(tag);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: verPad,
              ),
              //link
              ReusableTextformfield(
                  isTagFiled: false,
                  controller: _linkController,
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  isShow: false,
                  hint: "Web Url",
                  maxLine: 1),
              const SizedBox(
                height: verPad,
              ),
              //button
              InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _uploadBlog(
                          _titleController.text,
                          _contentController.text,
                          _image!,
                          _tags,
                          _linkController.text);
                    }
                  },
                  child: ReusableButton(lable: "Publish", isLoad: _isLoading)),
            ],
          ),
        ),
      ),
    );
  }
}
