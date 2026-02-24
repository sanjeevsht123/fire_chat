import 'package:fire/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationHandler {
  PushNotificationHandler._();

  ///Handle notification on different app state.

  ///Handle when app is foreground
  static void handleForegroundNotification(){
    FirebaseMessaging.onMessage.listen((message){
      showNotification(message);
    });
  }

  ///Handle when app is background
  void handleBackgroundNotification(){

  }

  /// Method to show notification

  static void showNotification(RemoteMessage message) {
    final notification = message.notification;

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'high_importance_channel', // Channel ID from init
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        );

    NotificationDetails details = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );

    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      details,
      payload: message.data['payload'],
    );
  }
}
