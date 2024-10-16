import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spread/firebase_options.dart';
import 'package:spread/notificaion/local_notification.dart';

import 'package:spread/provider/filter_provider.dart';

import 'package:spread/router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initilize local notofication
  await LocalNotification.notificatonInitilizer();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
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
