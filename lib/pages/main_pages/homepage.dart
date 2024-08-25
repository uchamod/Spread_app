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

        //add coustom scroll viwe
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.30,
              left: 22,
              child: Image.asset(
                "assets/adult/crown.png",
                scale: 1.15,
              ),
            ),
            CustomScrollView(
              slivers: <Widget>[
                //sliver app bar
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 12,

                  expandedHeight: 50,
                  floating: false,
                  pinned: false,
                  leadingWidth: 200,
                  leading: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/adult/Spread.svg",
                    ),
                  ),
                
                ),
                //add padding for grid viwe
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: horPad, vertical: verPad),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            childAspectRatio: 16 / 20),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ItemShowCard();
                      },
                      childCount: 10,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
