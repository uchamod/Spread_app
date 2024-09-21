import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spread/models/comment.dart';
import 'package:spread/models/people.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/services/firestore.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/widgets/comment_item.dart';
import 'package:spread/widgets/reusable_textformfield.dart';
import 'package:uuid/uuid.dart';

class CommentPage extends StatefulWidget {
  final String articalId;
  const CommentPage({super.key, required this.articalId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  final AuthServices _authServices = AuthServices();

  //add new commment
  Future<void> _addNewcomment(String comment) async {
    try {
      String commentId = const Uuid().v1();
      String currentUser = await _authServices.getCurrentUser()!.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser)
          .get();
      People user = People.fromJson((userData.data() as Map<String, dynamic>));
      Comment userComment = Comment(
          commentId: commentId,
          comment: comment,
          userId: user.userId,
          userProUrl: user.image!,
          userName: user.name,
          docId: widget.articalId,
          publishDate: DateTime.now(),
          likes: []);
      await FirestoreServices().commentOnMedia(userComment, false, context);
    } catch (err) {
      print("erro while commenting $err");
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("microblogs")
            .doc(widget.articalId)
            .collection("comments")
            .orderBy("publishDate", descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: secondorywhite,
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return CommentItem(
                userSnap: snapshot.data!.docs[index],
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
        child: Consumer<FilterProvider>(
          builder: (context, user, child) {
            user.refreshUser();
            People currentUser = user.getCurrentUser;
            return Row(
              children: [
                //avatar
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(RouterNames.profilePage,
                        extra: currentUser.userId);
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(currentUser.image),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                //comment field

                Expanded(
                  child: ReusableTextformfield(
                      controller: _commentController,
                      inputType: TextInputType.multiline,
                      inputAction: TextInputAction.done,
                      isShow: false,
                      hint: "comment...",
                      maxLine: 1,
                      isTagFiled: false),
                ),
                //send
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      _addNewcomment(_commentController.text);
                    },
                    child: const Icon(
                      Icons.send_rounded,
                      color: primaryYellow,
                      size: 32,
                    )),
              ],
            );
          },
        ),
      )),
    );
  }
}
