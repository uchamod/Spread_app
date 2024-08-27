import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horPad),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //add logo
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/adult/Spread.svg",
                        height: 35,
                      ),
                    ),
                    //filter chips

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          //all
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              backgroundColor: backgroundBlue,
                              side: const BorderSide(
                                  color: secondorywhite, width: 2),
                              label: Text(
                                "All",
                                style: Texystyles().subtitle,
                              ),
                              onSelected: (value) {},
                            ),
                          ),
                          //watch now
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              backgroundColor: backgroundBlue,
                              side: const BorderSide(
                                  color: secondorywhite, width: 2),
                              label: Text(
                                "Watch Now",
                                style: Texystyles().subtitle,
                              ),
                              onSelected: (value) {},
                            ),
                          ),
                          //habbits
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              backgroundColor: backgroundBlue,
                              side: const BorderSide(
                                  color: secondorywhite, width: 2),
                              label: Text(
                                "Habbits",
                                style: Texystyles().subtitle,
                              ),
                              onSelected: (value) {},
                            ),
                          ),
                          //dirty
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              backgroundColor: backgroundBlue,
                              side: const BorderSide(
                                  color: secondorywhite, width: 2),
                              label: Text(
                                "Dirty",
                                style: Texystyles().subtitle,
                              ),
                              onSelected: (value) {},
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    //item grid view
                    GridView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              childAspectRatio: 16 / 20),
                      itemBuilder: (context, index) {
                        return const ItemShowCard();
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
