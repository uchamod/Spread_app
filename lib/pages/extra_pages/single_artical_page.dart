import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class SingleArticalPage extends StatefulWidget {
  final Artical artical;
  const SingleArticalPage({super.key, required this.artical});

  @override
  State<SingleArticalPage> createState() => _SingleArticalPageState();
}

class _SingleArticalPageState extends State<SingleArticalPage> {
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
