import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spread/pages/main_pages/add_items.dart';
import 'package:spread/pages/main_pages/homepage.dart';
import 'package:spread/pages/main_pages/searchpage.dart';
import 'package:spread/pages/main_pages/profilepage.dart';
import 'package:spread/pages/main_pages/watch_page.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/util/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthServices _authServices = AuthServices();

  String id = "";
  List<Widget> _pages = [];
  @override
  void initState() {
    _pages = [
      const HomePage(),
      const WatchPage(),
      const AddItems(),
      const Items(),
      ProfilePage(
        userId: _authServices.getCurrentUser()!.uid,
      ),
    ];
    super.initState();
  }

  //get the user details
  Future<String> getUser() async {
    final User? user = _authServices.getCurrentUser();
    String userId = user!.uid;
    return userId;
  }

  int _selectedIndex = 0;
  
  //page changer
  void _onTapIcon(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //add gradient background
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [backgroundBlue, backgroundPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        //add pages
        body: _pages[_selectedIndex],
        //add radious
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: verPad),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(2, 4),
                    blurRadius: 4)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                backgroundColor: Colors.transparent,
                currentIndex: _selectedIndex,
                elevation: 2,
                selectedItemColor: primaryYellow,
                unselectedItemColor: secondorywhite,
                onTap: _onTapIcon,
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: backgroundBlue,
                    icon: SvgPicture.asset(
                      "assets/house.svg",
                      colorFilter: ColorFilter.mode(
                          _selectedIndex == 0 ? primaryYellow : secondorywhite,
                          BlendMode.srcIn),
                      height: 25,
                      width: 25,
                      semanticsLabel: 'My SVG Image',
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: backgroundBlue,
                    icon: SvgPicture.asset(
                      "assets/tv-minimal-play.svg",
                      colorFilter: ColorFilter.mode(
                          _selectedIndex == 1 ? primaryYellow : secondorywhite,
                          BlendMode.srcIn),
                      height: 25,
                      width: 25,
                      semanticsLabel: 'My SVG Image',
                    ),
                    label: 'Watch',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: backgroundBlue,
                    icon: SvgPicture.asset(
                      "assets/diamond-plus.svg",
                      colorFilter: ColorFilter.mode(
                          _selectedIndex == 2 ? primaryYellow : secondorywhite,
                          BlendMode.srcIn),
                      height: 25,
                      width: 25,
                      semanticsLabel: 'My SVG Image',
                    ),
                    label: 'Add',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: backgroundBlue,
                    icon: SvgPicture.asset(
                      "assets/file-text.svg",
                      colorFilter: ColorFilter.mode(
                          _selectedIndex == 3 ? primaryYellow : secondorywhite,
                          BlendMode.srcIn),
                      height: 25,
                      width: 25,
                      semanticsLabel: 'My SVG Image',
                    ),
                    label: "Check",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: backgroundBlue,
                    icon: SvgPicture.asset(
                      "assets/user-cog.svg",
                      colorFilter: ColorFilter.mode(
                          _selectedIndex == 4 ? primaryYellow : secondorywhite,
                          BlendMode.srcIn),
                      height: 25,
                      width: 25,
                      semanticsLabel: 'My SVG Image',
                    ),
                    label: 'Profile',
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
