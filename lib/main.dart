import 'package:flutter/material.dart';
import 'package:spread/router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Spread",
      debugShowCheckedModeBanner: false,
      routerConfig: RouterClass().router,
    );
  }
}
