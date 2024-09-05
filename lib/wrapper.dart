import 'package:flutter/material.dart';
import 'package:spread/layout/mobile_lauout.dart';
import 'package:spread/layout/responsive_layout.dart';
import 'package:spread/layout/web_layout.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileLayout: MobileLauout(),
      webLayout: WebLayout(),
    );
  }
}
