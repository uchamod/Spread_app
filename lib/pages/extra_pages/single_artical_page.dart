import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/services/user_services.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class SingleArticalPage extends StatefulWidget {
  final Artical artical;
  const SingleArticalPage({super.key, required this.artical});

  @override
  State<SingleArticalPage> createState() => _SingleArticalPageState();
}

class _SingleArticalPageState extends State<SingleArticalPage> {
  final AuthServices _authServices = AuthServices();
  final UserServices _userServices = UserServices();
  bool _isLike = false;
  int? _likeCount = 0;
  int? _dislikeCount = 0;

  //show likes
  Future<void> _getAndShowLikes() async {
    try {
      String userId = await _authServices.getCurrentUser()!.uid;
      DocumentSnapshot articalSnapshot = await FirebaseFirestore.instance
          .collection("microblogs")
          .doc(widget.artical.articalId)
          .get();

      List likes = (articalSnapshot.data() as Map<String, dynamic>)["likes"];
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
    await _userServices.likeOnMedia(userId, widget.artical.articalId, false);
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
            children: [
              //artical
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(1, 4),
                          blurRadius: 8,
                          color: secondoryBlack.withOpacity(0.5))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: verPad,
                    ),
                    //title
                    Text(
                      widget.artical.title,
                      style: Textstyles().title,
                    ),
                    const SizedBox(
                      height: verPad,
                    ),
                    //image
                    AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Image.network(
                          widget.artical.images,
                          fit: BoxFit.fitWidth,
                        )),
                    const SizedBox(
                      height: verPad,
                    ),
                    //content
                    Text(
                      widget.artical.discription,
                      style: Textstyles().subtitle.copyWith(fontSize: 12),
                    ),
                    const SizedBox(
                      height: verPad,
                    ),
                    //like or dislike
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        //route to comment page
        floatingActionButton: FloatingActionButton(
          backgroundColor: cardColor,
          elevation: 1,
          hoverColor: cardBlue,
          onPressed: () {
            GoRouter.of(context).pushNamed(RouterNames.commentPage, extra: {
              "MediaId": widget.artical.articalId,
              "isVideo": false,
            });
          },
          child: const Icon(
            Icons.comment_outlined,
            size: 30,
            color: secondorywhite,
          ),
        ),
      ),
    );
  }
}
