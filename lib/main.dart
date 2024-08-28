import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spread/provider/artical_provider.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/provider/people_provider.dart';
import 'package:spread/provider/video_provider.dart';
import 'package:spread/router/go_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ArticalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PeopleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FilterProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
