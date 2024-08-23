import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/widgets/item_show_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 210,
          backgroundColor: Colors.transparent,
          leading: SvgPicture.asset(
            "assets/adult/Spread.svg",
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: horPad, vertical: verPad),
          child: Column(
            children: [
              ItemShowCard(),
            ],
          ),
        ),
      ),
    );
  }
}
