import 'package:flutter/material.dart';
import 'package:spread/services/firebase_auth.dart';
import 'package:spread/util/constants.dart';
import 'package:spread/util/texystyles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                _authServices.singOut();
              },
              child: Text(
                "Sing Out",
                style: Textstyles().subtitle.copyWith(color: secondoryBlack),
              )),
        ],
      ),
      body: const Center(
        child: Text("profile page"),
      ),
    );
  }
}
