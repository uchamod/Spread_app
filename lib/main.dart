import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spread/firebase_options.dart';
import 'package:spread/notificaion/local_notification.dart';
import 'package:spread/notificaion/push_notification.dart';
import 'package:spread/provider/filter_provider.dart';
import 'package:spread/router/go_router.dart';
import 'package:spread/util/constants.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initilize local notofication
  await LocalNotification.notificatonInitilizer();
  tz.initializeTimeZones();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //initilize push notification
  await PushNotification.initilization();

  //listen incomming background message
  FirebaseMessaging.onBackgroundMessage(
      PushNotification.backgroundMessageHandler);

  //on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    await PushNotification.onBackgroundMessageTapped(message);
  });
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
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: secondoryBlack),
      debugShowCheckedModeBanner: false,
      routerConfig: RouterClass().router,
    );
  }
}
