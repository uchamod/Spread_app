import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/people.dart';
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
 late People writer;
  bool _isLike = false;
  bool _isDisLike = false;
  int? _likeCount = 0;
  int? _dislikeCount = 0;
  bool _isLoading = true;
  //show likes
  Future<void> _getAndShowLikes() async {
    try {
      String userId = await _authServices.getCurrentUser()!.uid;
      DocumentSnapshot articalSnapshot = await FirebaseFirestore.instance
          .collection("microblogs")
          .doc(widget.artical.articalId)
          .get();

      List likes = (articalSnapshot.data() as Map<String, dynamic>)["likes"];
      List dislikes =
          (articalSnapshot.data() as Map<String, dynamic>)["dislike"];
      _likeCount = likes.length;
      _dislikeCount = dislikes.length;
      //update like count
      if (likes.contains(userId)) {
        setState(() {
          _isLike = true;
        });
      }
      //update dislike count
      if (dislikes.contains(userId)) {
        setState(() {
          _isDisLike = true;
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

  //disLike
  Future<void> _disLikeOnMedia() async {
    String userId = await _authServices.getCurrentUser()!.uid;
    await _userServices.disLikeOnMedia(userId, widget.artical.articalId, false);
  }

  Future<void> _getArticalWriter() async {
    try {
      writer = await _userServices.getUserById(widget.artical.userId);
    
    } catch (err) {
      print("cannot get the writer");
    }
  }

  @override
  initState() {
    super.initState();

    writer = People(
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
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await Future.wait([
        _getArticalWriter(),
        _getAndShowLikes(),
      ]);
    } catch (err) {
      print('Error initializing data: $err');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              size: 24,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: horPad, vertical: verPad),
          child: Column(
            children: [
              //artical
              Container(
                padding: const EdgeInsets.symmetric(horizontal: commonpad),
                decoration: BoxDecoration(
                    color: secondoryBlack,
                    border: Border.all(color: primaryYellow, width: 0.5),
                    borderRadius: BorderRadius.circular(commonpad),
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
                    //writer details
                    Row(
                      children: [
                        //avatar
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                                RouterNames.profilePage,
                                extra: writer.userId);
                          },
                          child: CircleAvatar(
                            backgroundImage: writer.image != ""
                                ? NetworkImage(writer.image) as ImageProvider
                                : const AssetImage("assets/avatar2.png")
                                    as ImageProvider,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        //name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              writer.name,
                              style: Textstyles().subtitle,
                            ),
                            Text(
                              DateFormat.yMMMd().format(
                                  widget.artical.publishedDate.toDate()),
                              style: Textstyles()
                                  .label
                                  .copyWith(color: secondorywhite),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 6,
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
                    Image.network(
                      widget.artical.images,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(
                      height: verPad,
                    ),
                    //content
                    Text(
                      widget.artical.discription,
                      style: Textstyles().subtitle.copyWith(fontSize: 12),
                    ),

                    //tags
                    Wrap(
                      spacing: 8.0,
                      children: widget.artical.tags.map((tag) {
                        return Chip(
                          side: BorderSide.none,
                          label: Text(
                            tag,
                            style: Textstyles()
                                .label
                                .copyWith(color: secondoryBlack, fontSize: 11),
                          ),
                          backgroundColor: primaryYellow,
                        );
                      }).toList(),
                    ),
                    //like or dislike and comments
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
                                  _disLikeOnMedia();
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
                                  _disLikeOnMedia();
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
                        //route to comment page
                        IconButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed(
                              RouterNames.commentPage,
                              extra: {
                                "MediaId": widget.artical.articalId,
                                "isVideo": false,
                              },
                            );
                          },
                          icon: const Icon(Icons.comment_outlined),
                          iconSize: 24,
                          color: secondorywhite,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
