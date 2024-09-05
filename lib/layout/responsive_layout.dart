import 'package:flutter/material.dart';
import 'package:spread/util/constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget webLayout;
  const ResponsiveLayout(
      {super.key, required this.mobileLayout, required this.webLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webLayoutConstraints) {
          return mobileLayout;
        } else {
          return webLayout;
        }
      },
    );
  }
}
