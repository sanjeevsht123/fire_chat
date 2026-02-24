import 'package:fire/core/helper/permission_helper/permission_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification {
  PushNotification._();

  /// create instance of the firebase messaging

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// get the fcm token

  static Future<void> getFcmToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token:$fcmToken');
  }

  ///initialize firebase Messaging

  static Future<void> initializeMessaging() async {
    final _permission = await PermissionHelper.getNotificationPermission();
    if (_permission == AuthorizationStatus.authorized) {
      await getFcmToken();
    }
  }

  ///Initialize local notification
  static Future<void> initializeLocalNotification() async {
    ///Android Channel
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        if (kDebugMode) {
          print('Notification Payload:${response.payload}');
        }
      },
    );

    ///create android channel

    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
          'high_importance_channel',
          'High Importance Channel',
          importance: Importance.max,
          description: 'For High importance notification',
        );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);
  }
}
