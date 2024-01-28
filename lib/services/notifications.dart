import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static const String _channelId = 'rosreestr.notification.channel';
  static const String _channelName = 'rosreestr.notification.channel';


  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('launch_background');

  Future initializeNotification() async {
    final InitializationSettings settings =
        InitializationSettings(android: _androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(settings);
  }

  Future showNotification({required String title, required String body, int id = 0}) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(_channelId, _channelName,
            importance: Importance.max, priority: Priority.high);

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(id, title, body, details);
  }
}
