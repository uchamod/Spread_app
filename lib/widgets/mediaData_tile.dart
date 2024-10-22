import 'package:flutter/material.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class MediaListTile extends StatelessWidget {
  final bool isVideo;
  final Artical? artical;
  final Videos? video;
  final VoidCallback onDelete;

  const MediaListTile({
    required this.isVideo,
    this.artical,
    this.video,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: commonpad,
        vertical: commonpad,
      ),
      tileColor: secondoryBlack,
      leading: Icon(
        isVideo ? Icons.video_file_rounded : Icons.article_rounded,
        size: 32,
        color: secondorywhite.withOpacity(0.5),
      ),
      title: Text(isVideo ? video!.title : artical!.title),
      subtitle: Text(
        isVideo ? "Video" : "Article",
        style: Textstyles().label.copyWith(
          color: secondorywhite.withOpacity(0.5),
        ),
      ),
      trailing: IconButton(
        onPressed: onDelete,
        icon: Icon(
          Icons.delete,
          color: secondorywhite.withOpacity(0.5),
          size: 24,
        ),
      ),
    );
  }
}