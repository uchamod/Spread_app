import 'package:flutter/material.dart';
import 'package:spread/util/constants.dart';
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
  @override
  @override
  Widget build(BuildContext context) {
    //microblog tab
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            left: horPad, right: horPad, top: 15, bottom: 0),
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
                maxLine: 2),
            const SizedBox(
              height: verPad,
            ),
            //image
             Image.asset("assets/video.png",fit: BoxFit.fitWidth,),
              const SizedBox(
              height: verPad,
            ),
            //tags
            ReusableTextformfield(
              isTagFiled: false,
                controller: _tagsController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                isShow: false,
                hint: "Tag",
                maxLine: 1),
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
            const ReusableButton(lable: "Publish", isLoad: false),
          ],
        ),
      ),
    );
  }
}
