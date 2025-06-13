import 'package:check_license/api/LocalNotificationServerce.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseapi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('token is : $fcmToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Foreground message: ${message.notification?.title}');
        print('Data: ${message.data}');
        print('Body: ${message.notification?.body}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from notification: ${message.notification?.title}');
    });

    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        print('App opened from terminated state via notification.');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LocalNotificationService.showNotification(message);
      }
    });

    Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message,
    ) async {
      await Firebase.initializeApp();
      print('📥 Background message received: ${message.notification?.title}');
    }
  }
}
