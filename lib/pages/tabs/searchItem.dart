import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/people.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
import 'package:spread/widgets/artical_item_card.dart';
import 'package:spread/widgets/reusable_textformfield.dart';
import 'package:spread/widgets/user_item_card.dart';
import 'package:spread/widgets/video_item_card.dart';

class Serchitem extends StatefulWidget {
  final int index;
  const Serchitem({super.key, required this.index});

  @override
  State<Serchitem> createState() => _SerchitemState();
}

class _SerchitemState extends State<Serchitem> {
  final TextEditingController _searchController = TextEditingController();
  bool isDataShow = false;

  //method for filter data
  Stream<QuerySnapshot<Map<String, dynamic>>>? _searchData(int index) {
    if (index == 0) {
      return FirebaseFirestore.instance
          .collection("users")
          .where("name", isGreaterThanOrEqualTo: _searchController.text)
          .where("name", isLessThan: '${_searchController.text}z')
          .snapshots();
    } else if (index == 1) {
      return FirebaseFirestore.instance
          .collection("microblogs")
          .where("title", isGreaterThanOrEqualTo: _searchController.text)
          .where("title", isLessThan: '${_searchController.text}z')
          .where("tags", arrayContains: _searchController.text)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection("videos")
          .where("title", isGreaterThanOrEqualTo: _searchController.text)
          .where("title", isLessThan: '${_searchController.text}z')
          .where("tags", arrayContains: _searchController.text)
          .snapshots();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: horPad, vertical: verPad),
          child: Column(
            children: [
              //search field
              ReusableTextformfield(
                controller: _searchController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.done,
                isShow: false,
                hint: "search",
                maxLine: 1,
                isTagFiled: false,
                onSubmit: (String _) {
                  setState(() {
                    isDataShow = true;
                  });
                },
              ),
              const SizedBox(
                height: horPad,
              ),
              //render data
              isDataShow
                  ? StreamBuilder(
                      stream: _searchData(widget.index),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: secondorywhite,
                            ),
                          );
                        } else if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                              "No Search items",
                              style: Textstyles().subtitle,
                            ),
                          );
                        }
                        //show relevan data
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.requireData.size,
                              itemBuilder: (context, index) {
                                List document = snapshot.requireData.docs
                                    .map((doc) => doc.data())
                                    .toList();

                                return widget.index == 0
                                    ? UserItemCard(
                                        user: People.fromJson(document[index]))
                                    : widget.index == 1
                                        ? ArticalItemCard(
                                            artical: Artical.fromJson(
                                                document[index]))
                                        : VideoItemCard(
                                            video: Videos.fromJson(
                                                document[index]));
                              },
                            )
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "",
                        style: Textstyles().subtitle,
                      ),
                    ),
            ],
          )),
    );
  }
}
