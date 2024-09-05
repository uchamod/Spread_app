import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spread/pages/enter_pages/login_page.dart';
import 'package:spread/pages/error_page.dart';
import 'package:spread/pages/main_screen.dart';
import 'package:spread/util/constants.dart';

class MobileLauout extends StatelessWidget {
  const MobileLauout({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: primaryYellow,
          ));
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const MainScreen();
          } else if (snapshot.hasError) {
            return const ErrorPage();
          }
        }
        return LoginPage();
      },
    );
  }
}
