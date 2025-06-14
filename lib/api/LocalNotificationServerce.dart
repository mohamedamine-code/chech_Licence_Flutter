import 'package:check_license/api/Send_Emil.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    _notificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }
    static void showSimpleNotification(String title, String body)async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    _notificationsPlugin.show(0, title, body, details);
    await Mail().sendMail();
  }

  static void showNotification(RemoteMessage message) {
    _notificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
