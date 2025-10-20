import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:spread/router/go_router.dart';
import 'package:spread/router/route_names.dart';

class PushNotification {
  //crate instant
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  //initilize firebase massaging
  static Future<void> initilization() async {
    //request permission for notifiction
    NotificationSettings notificationSettings =
        await _firebaseMessaging.requestPermission(
            alert: true,
            announcement: true,
            badge: true,
            sound: true,
            provisional: true);

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print("authorization granted");
    } else {
      print("authorization not granted");
      return;
    }
  }

  static Future<void> getFcmToken(String userid) async {
    String? fcmToken = await _firebaseMessaging.getToken();
    await FirebaseFirestore.instance.collection("users").doc(userid).update({
      "fcmToken": fcmToken,
    });
    print("device FCM token $fcmToken");
  }

  //craete background message handler
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    if (message.notification != null) {
      print("background message handler ${message.notification!.title}");
    }
  }

  // on background notification tapped function (pass the payload data to the message opener screen)
  static Future<void> onBackgroundMessageTapped(RemoteMessage message) async {
    if (message.notification != null) {
      RouterClass().router.pushNamed(RouterNames.singleArticalPage,
          extra: (message.data)['artical']);
    }
  }
}
