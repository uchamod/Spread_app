import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/services/user_services.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/video_item_card.dart';
import 'package:spread/widgets/video_player.dart';

class SingleVideoPage extends StatefulWidget {
  final Videos video;
  const SingleVideoPage({super.key, required this.video});

  @override
  State<SingleVideoPage> createState() => _SingleVideoPageState();
}

class _SingleVideoPageState extends State<SingleVideoPage> {
  final AuthServices _authServices = AuthServices();
  final UserServices _userServices = UserServices();
  bool _isLike = false;
  int? _likeCount = 0;
  int? _dislikeCount = 0;

  //show likes
  Future<void> _getAndShowLikes() async {
    try {
      String userId = await _authServices.getCurrentUser()!.uid;
      DocumentSnapshot videoSnapshot = await FirebaseFirestore.instance
          .collection("videos")
          .doc(widget.video.videoId)
          .get();

      List likes = (videoSnapshot.data() as Map<String, dynamic>)["likes"];
      _likeCount = likes.length;
      if (likes.contains(userId)) {
        setState(() {
          _isLike = true;
        });
      }
    } catch (err) {
      print("error while like to blog $err");
    }
  }

  //like
  Future<void> _likeOnMedia() async {
    String userId = await _authServices.getCurrentUser()!.uid;
    await _userServices.likeOnMedia(userId, widget.video.videoId, true);
  }

  @override
  void initState() {
    _getAndShowLikes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [backgroundBlue, backgroundPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          //back to home
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).goNamed(RouterNames.home);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: secondorywhite,
                size: 25,
              )),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: horPad, vertical: verPad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //video
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CoustomVideoPlayer(videoUrl: widget.video.videoUrl),
              ),
              const SizedBox(
                height: verPad,
              ),
              //title
              Text(
                widget.video.title,
                style: Textstyles().title,
              ),
              const SizedBox(
                height: verPad,
              ),
              //tags
              Row(
                children: [
                  for (int i = 0; i < widget.video.tags.length; i++)
                    Wrap(
                      children: [
                        Text(
                          widget.video.tags[i],
                          style: Textstyles().label,
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    )
                ],
              ),
              const SizedBox(
                height: verPad,
              ),
              //like dislike
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //like
                  _isLike
                      ? IconButton(
                          onPressed: () {
                            _likeOnMedia();
                            setState(() {
                              _likeCount = _likeCount! - 1;
                              _isLike = false;
                            });
                          },
                          icon: const Icon(
                            Icons.thumb_up_alt_sharp,
                            color: secondorywhite,
                            size: 24,
                          ))
                      : IconButton(
                          onPressed: () {
                            _likeOnMedia();
                            setState(() {
                              _likeCount = _likeCount! + 1;
                              _isLike = true;
                            });
                          },
                          icon: const Icon(
                            Icons.thumb_up_alt_outlined,
                            color: secondorywhite,
                            size: 24,
                          )),
                  Text(
                    _likeCount.toString(),
                    style: Textstyles().label,
                  ),
                  const SizedBox(
                    width: horPad,
                  ),
                  //dislike
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.thumb_down_alt_outlined,
                        color: secondorywhite,
                        size: 24,
                      )),
                  Text(
                    _dislikeCount.toString(),
                    style: Textstyles().label,
                  ),
                ],
              ),
              //other videos
              // FutureBuilder(
              //   future:
              //       Provider.of<FilterProvider>(context, listen: false)
              //           .setData(context),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState ==
              //         ConnectionState.waiting) {
              //       return const Center(
              //         child: CircularProgressIndicator(
              //           color: secondorywhite,
              //         ),
              //       );
              //     }
              //     if (snapshot.hasError) {
              //       return Center(
              //           child: Text(
              //         "Network Error",
              //         style: Textstyles().body,
              //       ));
              //     }
              Expanded(
                child: Consumer<FilterProvider>(
                  builder: (context, filterdata, child) {
                    List<Videos> videoData =
                        filterdata.filterData.whereType<Videos>().toList();
                    return ListView.builder(
                      // gridDelegate:
                      //     const SliverGridDelegateWithFixedCrossAxisCount(
                      //         crossAxisCount: 1, mainAxisSpacing: 15),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //todo : check lenth in future
                      itemCount: videoData.length,
                      itemBuilder: (context, index) {
                        // if (videoData[index].videoId !=
                        //     widget.video.videoId) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: VideoItemCard(video: videoData[index]),
                        );
                        //     }
                      },
                    );
                  },
                ),
              ),
              // },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
