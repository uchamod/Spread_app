import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> _NotificationResponse(NotificationResponse) async {}
  //initialize notification service
  static Future<void> notificatonInitilizer() async {
    //android initilization
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/launcher_icon");
    //ios initilization

    const DarwinInitializationSettings initializationSettingsIos =
        DarwinInitializationSettings();
    //combine the android and ios settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: initializationSettingsIos);

    //initilize flutterNotificaionPlugin
    await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings, //initilize devices
        onDidReceiveBackgroundNotificationResponse:
            _NotificationResponse, //when click the notification execute a response like navigation
        onDidReceiveNotificationResponse: _NotificationResponse);

    //get  the permission from the android system to show notification
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  //create and show instant local notifications
  static Future<void> instantNotification(
      {required String title, required String body}) async {
    //platform details for both android and ios
    const NotificationDetails _platformDetails = NotificationDetails(
        //chanel for android
        android: AndroidNotificationDetails(
          "android_chanel_id",
          "android_chanel_name",
          importance: Importance.max,
          priority: Priority.high,
        ),
        //chanel for ios
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ));
    //show the notification
    await _flutterLocalNotificationsPlugin.show(
        0, title, body, _platformDetails);
  }

  //shedueld notification
  static Future<void> schedulNotification(
      {required String title,
      required String body,
      required DateTime schedulTime}) async {
    //platform details for both android and ios
    const NotificationDetails _platformDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "android_chanel_id",
        "android_chanel_name",
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    //schedule the notification
    await _flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
        tz.TZDateTime.from(schedulTime, tz.local), _platformDetails,
        uiLocalNotificationDateInterpretation:
           UILocalNotificationDateInterpretation.absoluteTime,
           matchDateTimeComponents: DateTimeComponents.time);
  }

  //Recurring notification

}
