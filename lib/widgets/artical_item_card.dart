import 'package:flutter/material.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class ArticalItemCard extends StatelessWidget {
  final Artical artical;
  const ArticalItemCard({super.key, required this.artical});

  @override
  Widget build(BuildContext context) {
    return
        //  Stack(
        //   children: [
        //     //add blury backdrop
        //     Positioned.fill(
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(16),
        //         child: BackdropFilter(
        //           filter: ImageFilter.blur(
        //             sigmaX: 10,
        //             sigmaY: 10,
        //           ),
        //           //coustom card
        //           child:
        Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: cardColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 3),
            blurRadius: 6,
            color: const Color(000000).withOpacity(
              0.18,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.asset(
              "assets/Spicy.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horPad, vertical: verPad),
            child: Column(
              children: [
                Text(
                  artical.title,
                  style: Textstyles().title,
                ),
                Text(
                  artical.discription,
                  style: Textstyles().body,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
    //    ),
    //  ),
    //   ),
    // ],
    //);
  }
}
