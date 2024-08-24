import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/widgets/item_show_card.dart';

//homepage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //appbar with logo
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 210,
          backgroundColor: Colors.transparent,
          leading: SvgPicture.asset(
            "assets/adult/Spread.svg",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horPad),
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                child: Image.asset(
                  "assets/adult/crown.png",
                  scale: 1.15,
                ),
              ),
              SingleChildScrollView(
                child: GridView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8,
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      childAspectRatio: 16 / 20),
                  itemBuilder: (context, index) {
                    return ItemShowCard();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
