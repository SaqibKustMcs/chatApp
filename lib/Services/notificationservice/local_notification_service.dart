import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  // after this create a method initialize to initialize  localnotification
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //after this create a method initialize to initialize  localnotification

  static Future<void> initialize() async {
    print(",,,,,,,,,,,,,,,,,,");
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );
    print(",,,,,,,,,,,,,,,,,,");

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        print(",,,,,,,,,,,,,,,,,,");
        if (notificationResponse != null) {
          print("...........notR$notificationResponse");
        }
        print(",,,,,,,,,,,,,,,,,,");
        // ...
      },
    );
  }

  // after initialize we create channel in createanddisplaynotification method

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotificationapp",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(


        id,
        message.notification!.title,
         message.notification!.body,



        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
