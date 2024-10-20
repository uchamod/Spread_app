import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/people.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/services/user_services.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/detaild_video_item_card.dart';
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
  People creator = People(
      userId: "",
      name: "UnKnown",
      discription: "none",
      location: "out of",
      password: "1234",
      image: "",
      followers: [],
      followings: [],
      joinedDate: DateTime.now(),
      updatedDate: DateTime.now());

  bool _isLike = false;
  bool _isDisLike = false;
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
      List dislikes = (videoSnapshot.data() as Map<String, dynamic>)["dislike"];
      _likeCount = likes.length;
      _dislikeCount = dislikes.length;
      //update like list
      if (likes.contains(userId)) {
        setState(() {
          _isLike = true;
        });
      }
      //update dislike list
      if (dislikes.contains(userId)) {
        setState(() {
          _isDisLike = true;
        });
      }
    } catch (err) {
      print("error while like to video $err");
    }
  }

  //like
  Future<void> _likeOnMedia() async {
    String userId = await _authServices.getCurrentUser()!.uid;
    await _userServices.likeOnMedia(userId, widget.video.videoId, true);
  }

  Future<void> _dislikeOnMedia() async {
    String userId = await _authServices.getCurrentUser()!.uid;
    await _userServices.disLikeOnMedia(userId, widget.video.videoId, true);
  }

  Future<void> _getVideoPublisher() async {
    try {
      creator = await _userServices.getUserById(widget.video.userId);
    } catch (err) {
      print("cannot get the video writer");
    }
  }

  @override
  void initState() {
    _getVideoPublisher();
    _getAndShowLikes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //tags
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: commonpad, vertical: commonpad),
              child: Wrap(
                spacing: 8.0,
                children: widget.video.tags.map((tag) {
                  return Chip(
                    side: BorderSide.none,
                    label: Text(
                      tag,
                      style: Textstyles()
                          .label
                          .copyWith(color: secondoryBlack, fontSize: 11),
                    ),
                    backgroundColor: primaryYellow,
                    deleteIcon: const Icon(
                      Icons.close,
                      color: secondoryBlack,
                      grade: 15,
                    ),
                  );
                }).toList(),
              ),
            ),
            //video
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CoustomVideoPlayer(videoUrl: widget.video.videoUrl),
            ),
            const SizedBox(
              height: verPad,
            ),
              
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: commonpad, vertical: commonpad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text(
                    widget.video.title,
                    style: Textstyles().subtitle,
                  ),
                
                  Text(
                    DateFormat.yMMMd()
                        .format(widget.video.publishedDate.toDate()),
                    style: Textstyles().label,
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
                                color: primaryYellow,
                                size: 24,
                              ))
                          : IconButton(
                              onPressed: () {
                                _likeOnMedia();
                                setState(() {
                                  _likeCount = _likeCount! + 1;
                                  _dislikeCount = _dislikeCount == 0
                                      ? 0
                                      : _dislikeCount! - 1;
                                  _isLike = true;
                                  _isDisLike = false;
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
                      _isDisLike
                          ? IconButton(
                              onPressed: () {
                                _dislikeOnMedia();
                                setState(() {
                                  _dislikeCount = _dislikeCount! - 1;
                                  _isDisLike = false;
                                });
                              },
                              icon: const Icon(
                                Icons.thumb_down_alt_rounded,
                                color: primaryYellow,
                                size: 24,
                              ))
                          : IconButton(
                              onPressed: () {
                                _dislikeOnMedia();
                                setState(() {
                                  _dislikeCount = _dislikeCount! + 1;
                                  _likeCount =
                                      _likeCount == 0 ? 0 : _likeCount! - 1;
                                  _isDisLike = true;
                                  _isLike = false;
                                });
                              },
                              icon: const Icon(
                                Icons.thumb_down_off_alt_rounded,
                                color: secondorywhite,
                                size: 24,
                              )),
                      Text(
                        _dislikeCount.toString(),
                        style: Textstyles().label,
                      ),
                        const SizedBox(
                        width: horPad,
                      ),
                      //to comment screen
                      IconButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(RouterNames.commentPage, extra: {
                              "MediaId": widget.video.videoId,
                              "isVideo": true,
                            });
                          },
                          icon: const Icon(
                            Icons.comment_outlined,
                            color: secondorywhite,
                            size: 28,
                          ))
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  //publisher details
                  Row(
                    children: [
                      //avatar
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                              RouterNames.profilePage,
                              extra: creator.userId);
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(creator.image),
                          radius: 18,
                        ),
                      ),
                      const SizedBox(
                        width: horPad,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            creator.name,
                            style: Textstyles().body,
                          ),
                          Text(
                            creator.followers.length.toString() + " Followers",
                            style: Textstyles().label.copyWith(color:secondorywhite.withOpacity(0.5),fontSize: 12 ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
           
            const SizedBox(
              width: 25,
            ),
              
            const Divider(
              color: secondorywhite,
              thickness: 0.5,
            ),
            //other videos
            Consumer<FilterProvider>(
              builder: (context, filterdata, child) {
                List<Videos> videoData =
                    filterdata.filterData.whereType<Videos>().toList();
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  //todo : check lenth in future
                  itemCount: videoData.length,
                  itemBuilder: (context, index) {
                   
                    return Padding(
                      padding: const EdgeInsets.only(bottom: commonpad),
                      child:DetaildVideoItemCard(video: videoData[index], username: creator.name),
                    );
                        
                  },
                );
              },
            ),
          
          ],
        ),
      ),
    );
  }
}
