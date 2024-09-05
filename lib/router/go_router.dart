import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/pages/enter_pages/auth_page.dart';
import 'package:spread/pages/enter_pages/intro_page.dart';
import 'package:spread/pages/enter_pages/login_page.dart';
import 'package:spread/pages/enter_pages/user_deatils_page.dart';
import 'package:spread/pages/error_page.dart';
import 'package:spread/pages/main_screen.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/wrapper.dart';

//router class
class RouterClass {
  final router = GoRouter(
      initialLocation: "/",
      errorPageBuilder: (context, state) {
        return const MaterialPage(child:  ErrorPage());
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
            return AuthPage();
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
        )
      ]);
}
