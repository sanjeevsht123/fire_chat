import 'package:firebase_messaging/firebase_messaging.dart';

class PermissionHelper {
PermissionHelper._();

/// Notification permission helper

 static Future<AuthorizationStatus> getNotificationPermission() async{
   final _firebaseMessaging=FirebaseMessaging.instance;
   final permission= await _firebaseMessaging.requestPermission(
     alert: true,
     badge: true,
     sound: true,
     provisional: false
   );
   if(permission.authorizationStatus==AuthorizationStatus.authorized){
     return AuthorizationStatus.authorized;
   }else{
     return AuthorizationStatus.denied;
   }
}


}