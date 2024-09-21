import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/models/artical.dart';
import 'package:spread/models/watch_now.dart';
import 'package:spread/pages/enter_pages/auth_page.dart';
import 'package:spread/pages/enter_pages/intro_page.dart';
import 'package:spread/pages/enter_pages/login_page.dart';
import 'package:spread/pages/enter_pages/user_deatils_page.dart';
import 'package:spread/pages/error_page.dart';
import 'package:spread/pages/extra_pages/comment_page.dart';
import 'package:spread/pages/extra_pages/single_artical_page.dart';
import 'package:spread/pages/extra_pages/single_video_page.dart';
import 'package:spread/pages/main_pages/profilepage.dart';
import 'package:spread/pages/main_screen.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/wrapper.dart';

//router class
class RouterClass {
  final router = GoRouter(
      initialLocation: "/",
      errorPageBuilder: (context, state) {
        return const MaterialPage(child: ErrorPage());
      },
      routes: [
        GoRoute(
          path: "/home",
          name: RouterNames.home,
          builder: (context, state) {
            return const MainScreen();
          },
        ),
        GoRoute(
          path: "/",
          builder: (context, state) {
            return const Wrapper();
          },
        ),
        GoRoute(
          path: "/intro",
          name: RouterNames.introPage,
          builder: (context, state) {
            return const IntroPage();
          },
        ),
        GoRoute(
          path: "/auth",
          name: RouterNames.authPage,
          builder: (context, state) {
            return const AuthPage();
          },
        ),
        GoRoute(
          path: "/deatils",
          name: RouterNames.userDetailsPage,
          builder: (context, state) {
            final String username =
                (state.extra as Map<String, dynamic>)["username"];
            final String password =
                (state.extra as Map<String, dynamic>)["password"];
            return UserDeatilsPage(
              username: username,
              password: password,
            );
          },
        ),
        GoRoute(
          path: "/login",
          name: RouterNames.loginPage,
          builder: (context, state) {
            return LoginPage();
          },
        ),
        //route to profile page
        GoRoute(
          path: "/profile",
          name: RouterNames.profilePage,
          builder: (context, state) {
            final String user = state.extra as String;
            return ProfilePage(
              userId: user,
            );
          },
        ),
        //artical page
        GoRoute(
          path: "/articalPage",
          name: RouterNames.singleArticalPage,
          builder: (context, state) {
            final artical = state.extra as Artical;
            return SingleArticalPage(
              artical: artical,
            );
          },
        ),
        //video page
        GoRoute(
          path: "/videos",
          name: RouterNames.singleVideoPage,
          builder: (context, state) {
            final video = state.extra as Videos;
            return SingleVideoPage(video: video);
          },
        ),
        GoRoute(
          path: "/commentPage",
          name: RouterNames.commentPage,
          builder: (context, state) {
            final String articalId = state.extra as String;
            return CommentPage(articalId: articalId,);
          },
        )
      ]);
}
