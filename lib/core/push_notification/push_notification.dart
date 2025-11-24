import 'package:fire/core/helper/permission_helper/permission_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification{
  /// create instance of the firebase messaging

  final FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;

  /// get the fcm token

   static Future<void> getFcmToken() async{
     final FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;
     final fcmToken=await _firebaseMessaging.getToken();
     print('FCM Token:$fcmToken');
   }

   ///initialize firebase Messaging

   static Future<void> initializeMessaging()async{
     final _permission=await PermissionHelper.getNotificationPermission();
     if(_permission==AuthorizationStatus.authorized){
       await getFcmToken();
     }
   }

}