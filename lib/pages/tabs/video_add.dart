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

class VideoAdd extends StatefulWidget {
  const VideoAdd({super.key});

  @override
  State<VideoAdd> createState() => _VideoAddState();
}

class _VideoAddState extends State<VideoAdd> {
  //controller
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final FirestoreServices _firestoreServices = FirestoreServices();
  //form key
  final _formKey = GlobalKey<FormState>();
  File? _image;
  File? _video;
  bool _isLoading = false;
  //tag list
  List<String> _tags = [];
  //upload thubnaill
  Future<void> pickThubnaill() async {
    ImagePicker _imgPicker = ImagePicker();
    final image = await _imgPicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  //pick video
  Future<void> pickVideo() async {
    final _Picker = ImagePicker();
    final video = await _Picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _video = File(video.path);
      });
    }
  }

  //upload video
  Future<void> _videoUpload(String title, File video, File image,
      List<String> tags, String url) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _firestoreServices.addVideo(
          title, image, video, tags, url, context);
      setState(() {
        _isLoading = false;
        _titleController.clear();
        _tagsController.clear();
        _linkController.clear();
      });
      GoRouter.of(context).goNamed(RouterNames.home);
    } catch (err) {
      print("something going wrong");
    }
  }

  //tag adder
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
    _linkController.dispose();
    _tagsController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    //microblog tab
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            left: horPad, right: horPad, top: 15, bottom: 100),
        child: Form(
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
              //video
              GestureDetector(
                onTap: () {
                  pickVideo();
                },
                child: _video != null
                    ? Text(
                        "Video Selected ${_video!.path}",
                        style: Textstyles().body,
                      )
                    : Image.asset(
                        "assets/video.png",
                        fit: BoxFit.fitWidth,
                      ),
              ),
              const SizedBox(
                height: verPad,
              ),
              Text(
                "select Thubnail",
                style: Textstyles().body,
              ),
              const SizedBox(
                height: verPad,
              ),
              //thubnail
              GestureDetector(
                onTap: () {
                  pickThubnaill();
                },
                child: _image != null
                    ? AspectRatio(
                        aspectRatio: 16 / 9, child: Image.file(_image!))
                    : Image.asset(
                        "assets/tubnail.png",
                        fit: BoxFit.fitWidth,
                      ),
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
                  // if (_formKey.currentState!.validate() &&
                      // _video != null &&
                      // _image != null) {
                    _videoUpload(_titleController.text, _video!, _image!, _tags,
                        _linkController.text);
                  // } else {
                  
                  // }
                },
                child: ReusableButton(lable: "Publish", isLoad: _isLoading),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
