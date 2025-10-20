import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/services/common_functions.dart';
import 'package:spread/services/firestore.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/mediaData_tile.dart';

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
  bool _isLoading = false;
  //delete media alert
  Future<bool> _deleteMedia(BuildContext context, bool isVideo,
      Artical? artical, Videos? video) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: secondoryBlack.withOpacity(0.8),
          title: Text(
            "Are You Sure?",
            style: Textstyles().subtitle,
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: Textstyles().body,
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(
                "Delete",
                style: Textstyles().body.copyWith(color: primaryYellow),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (result != true) return false;

    setState(() => _isLoading = true);

    try {
      if (isVideo) {
        await FirestoreServices()
            .deletePost(video!.videoId, true, video.userId);
      } else {
        await FirestoreServices()
            .deletePost(artical!.articalId, false, artical.userId);
      }

      // Refresh the provider data
      if (mounted) {
        Provider.of<FilterProvider>(context, listen: false)
            .filterByUserId(widget.userId);
      }

      return true;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete: ${e.toString()}')),
        );
      }
      return false;
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context, filterData, child) {
        filterData.filterByUserId(widget.userId);
        List<dynamic> userMediaData = filterData.userData;

        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userMediaData.isEmpty) {
          return Center(
            child: Text(
              'No media found',
              style: Textstyles().body,
            ),
          );
        }
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
                  dynamic item = userMediaData[index];
                  return MediaListTile(
                    isVideo: item is Videos,
                    artical: item is Artical ? item : null,
                    video: item is Videos ? item : null,
                    onDelete: () async {
                      final result = await _deleteMedia(
                        context,
                        item is Videos,
                        item is Artical ? item : null,
                        item is Videos ? item : null,
                      );
                      if (result && mounted) {
                        CommonFunctions().massage(
                          "Media Deleted Successfully",
                          Icons.check_circle,
                          Colors.green,
                          context,
                          2,
                        );
                      }
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  
}
