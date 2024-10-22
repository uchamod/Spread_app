import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
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

  //combine two   Stream<QuerySnapshot<Map<String, dynamic>>>?

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? combineStreams(
    Stream<QuerySnapshot<Map<String, dynamic>>>? stream1,
    Stream<QuerySnapshot<Map<String, dynamic>>>? stream2,
  ) {
    if (stream1 == null || stream2 == null) {
      return null;
    }
    return Rx.combineLatest2(
      stream1,
      stream2,
      (QuerySnapshot<Map<String, dynamic>> querySnapshot1,
          QuerySnapshot<Map<String, dynamic>> querySnapshot2) {
        // You can merge the snapshots as you like here.
        // In this example, we combine the documents from both snapshots.

        List<QueryDocumentSnapshot<Map<String, dynamic>>> combinedDocs = [
          ...querySnapshot1.docs,
          ...querySnapshot2.docs,
        ];

        // Create a new QuerySnapshot or return a custom stream
        return combinedDocs;
      },
    );
  }

  //method for filter data
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? _searchData(
      int index) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? data1;
    Stream<QuerySnapshot<Map<String, dynamic>>>? data2;
    if (index == 0) {
      data1 = FirebaseFirestore.instance
          .collection("users")
          .where("name", isGreaterThanOrEqualTo: _searchController.text)
          .where("name", isLessThan: '${_searchController.text}z')
          .snapshots();
      data2 = FirebaseFirestore.instance
          .collection("users")
          .where("location", isGreaterThanOrEqualTo: _searchController.text)
          .where("location", isLessThan: '${_searchController.text}z')
          .snapshots();
    } else if (index == 1) {
      data1 = FirebaseFirestore.instance
          .collection("microblogs")
          .where("tags", arrayContains: _searchController.text)
          .snapshots();
      data2 = FirebaseFirestore.instance
          .collection("microblogs")
          .where("title", isGreaterThanOrEqualTo: _searchController.text)
          .where("title", isLessThan: '${_searchController.text}z')
          .snapshots();
    } else {
      data1 = FirebaseFirestore.instance
          .collection("videos")
          .where("tags", arrayContains: _searchController.text)
          .snapshots();
      data2 = FirebaseFirestore.instance
          .collection("videos")
          .where("title", isGreaterThanOrEqualTo: _searchController.text)
          .where("title", isLessThan: '${_searchController.text}z')
          .snapshots();
    }

    return combineStreams(data1, data2);
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
                  ? StreamBuilder<
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                      stream: _searchData(widget.index),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: secondorywhite,
                            ),
                          );
                        } else if (!snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "No data found",
                                  style: Textstyles().body,
                                ),
                              ),
                            ],
                          );
                        }
                        //show relevan data
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.requireData.length,
                              itemBuilder: (context, index) {
                                List document = snapshot.requireData
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
