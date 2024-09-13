import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spread/router/route_names.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class Extralogin extends StatefulWidget {
  // final Function() googleSingIn;
  const Extralogin({
    super.key,
  });

  @override
  State<Extralogin> createState() => _ExtraloginState();
}

class _ExtraloginState extends State<Extralogin> {
  final AuthServices _authServices = AuthServices();
  //sing in with google
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      // Sign in with Google
      await _authServices.googleSingIn(context);

      GoRouter.of(context).goNamed(RouterNames.home);
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  //sing in anonymously
  Future<void> _singInWithAnonymously(BuildContext context) async {
    try {
      await _authServices.anonymousSingIn(context);
      GoRouter.of(context).goNamed(RouterNames.home);
    } catch (e) {
      print("just error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //continue msg
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Divider(
              color: secondorywhite,
            ),
            Text("Continue with",
                style: Textstyles().body.copyWith(color: primaryYellow)),
            const Divider(
              color: secondorywhite,
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        //login methods
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //google login
            InkWell(
              onTap: () async {
                await _signInWithGoogle(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(color: secondorywhite, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/Google.svg",
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text("Google", style: Textstyles().body),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: verPad,
            ),
            //anonymous login
            InkWell(
              onTap: () async {
              await  _singInWithAnonymously(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(color: secondorywhite, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/incognito.svg",
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text("anonymous", style: Textstyles().body),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
