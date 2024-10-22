import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/watch_now.dart';

import 'package:spread/provider/filter_provider.dart';
import 'package:spread/services/common_functions.dart';
import 'package:spread/services/firestore.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class EditMedia extends StatefulWidget {
  final String userId;
  const EditMedia({
    super.key,
    required this.userId,
  });

  @override
  State<EditMedia> createState() => _EditMediaState();
}

class _EditMediaState extends State<EditMedia> {
  //show dialog option box
  _deleteMedia(BuildContext parentcontext, bool isVideo, Artical? artical,
      Videos? video) async {
    //show media selector | dialog box
    return showDialog(
      context: parentcontext,
      builder: (context) {
        return SimpleDialog(
          alignment: Alignment.center,
          backgroundColor: secondoryBlack.withOpacity(0.8),
          title: Text(
            "Are You Sure ?",
            style: Textstyles().subtitle,
          ),
          children: [
            //take a photo
            SimpleDialogOption(
              child: Text(
                "Delete",
                style: Textstyles().body.copyWith(color: primaryYellow),
              ),
              onPressed: () async {
                isVideo
                    ? FirestoreServices()
                        .deletePost(video!.videoId, true, video.userId)
                    : FirestoreServices()
                        .deletePost(artical!.articalId, false, artical.userId);
                Navigator.of(context).pop();
              },
            ),
            const Divider(),

            //cancel selection
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: Textstyles().body,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context, filterData, child) {
        filterData.filterByUserId(widget.userId);
        List<dynamic> userMediaData = filterData.userData;
        userMediaData.shuffle();
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: commonpad, vertical: commonpad),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: userMediaData.length,
                itemBuilder: (context, index) {
                  return userMediaData[index] is Artical
                      ? _mediaRow(
                          context: context,
                          isVideo: false,
                          artical: userMediaData[index])
                      : _mediaRow(
                          context: context,
                          isVideo: true,
                          video: userMediaData[index]);
                },
              )
            ],
          ),
        );
      },
    );
  }

  //List tile for show video and artical data
  Widget _mediaRow(
      {required BuildContext context,
      required bool isVideo,
      Artical? artical,
      Videos? video}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: commonpad, vertical: commonpad),
      tileColor: secondoryBlack,
      leading: Icon(
        isVideo ? Icons.video_file_rounded : Icons.article_rounded,
        size: 32,
        color: secondorywhite.withOpacity(0.5),
      ),
      title: Text(isVideo ? video!.title : artical!.title),
      subtitle: Text(
        isVideo ? "Video" : "Artical",
        style:
            Textstyles().label.copyWith(color: secondorywhite.withOpacity(0.5)),
      ),
      trailing: IconButton(
          //delete media data and refresh
          onPressed: () async {
            _deleteMedia(context, isVideo, artical, video);
            CommonFunctions().massage(
                "Deleting Media...", Icons.delete, deleteColor, context, 4);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditMedia(
                    userId: widget.userId,
                  ),
                ));
          },
          icon: Icon(
            Icons.delete,
            color: secondorywhite.withOpacity(0.5),
            size: 24,
          )),
    );
  }
}
