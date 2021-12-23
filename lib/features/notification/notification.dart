import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_type.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message ${message.data}');
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            priority: Priority.high,
            importance: Importance.max,
            fullScreenIntent: true,
            timeoutAfter: 10000,
          ),
          iOS: IOSNotificationDetails(sound: "ringing_tone")));

  _handleMessage(message);
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications',
  '',
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initMessaging() {
  var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInit = IOSInitializationSettings();
  var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
  var fltNotification = FlutterLocalNotificationsPlugin();
  fltNotification.initialize(initSetting);
  var androidDetails = AndroidNotificationDetails(
    'high_importance_channel', // id
    'High Importance Notifications',
    '', // title// description
    importance: Importance.high,
  );
  var iosDetails = IOSNotificationDetails();
  var generalNotificationDetails =
      NotificationDetails(android: androidDetails, iOS: iosDetails);

  setupInteractedMessage();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (message.data['type'] == 'cellCall' ||
        message.data['type'] == 'pastorCall') {
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  icon: android?.smallIcon,
                  priority: Priority.high,
                  importance: Importance.max,
                  fullScreenIntent: true,
                  timeoutAfter: 10000,
                ),
                iOS: IOSNotificationDetails()));
      }
    }
    print('Message ${message.data}');
    _handleMessage(message);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

void _handleMessage(RemoteMessage message) {
  if (message.data['type'] == NotificationType.event) {
    //Get.to(CellIncomingCall(cellName: message.data['cell']));
  }
  if (message.data['type'] == NotificationType.livestream) {
    //Get.to(PastorIncomingCall());
  }
  if (message.data['type'] == NotificationType.testimony) {
    //Get.to(CellIncomingCall(cellName: message.data['cell']));
  }
  if (message.data['type'] == NotificationType.prayer ||
      message.data['type'] == NotificationType.prayerLike ||
      message.data['type'] == NotificationType.prayerComment) {
    //Get.to(PastorIncomingCall());
  }
}
