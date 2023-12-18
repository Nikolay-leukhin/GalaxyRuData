import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxy_rudata/services/preferences.dart';

import '../../../models/notification.dart';
import '../../notifications.dart';
import '../api_service.dart';
import '../endpoints.dart';

class BackgroundNotificationsService {
  static Future backgroundNotificationsTask() async {
    final notifications = await _getAvailableNotifications();
    if (notifications.isNotEmpty) _showNotifications(notifications);
  }

  static Future<void> markNotificationsAsRead() async {
    final dio = await _getDio();
    final notifications = await _getAvailableNotifications();
    for (NotificationModel notification in notifications) {
      dio.post(ApiEndpoints.readNotification, data: {"id": notification.id});
    }
  }

  static _showNotifications(List<NotificationModel> notifications) async {
    final notificationsService = NotificationsService();
    await notificationsService.initializeNotification();
    for (var notification in notifications) {
      await notificationsService.showNotification(
          title: 'Новое событие',
          body: notification.message,
          id: notification.id);
    }
  }

  static Future<List<NotificationModel>> _getAvailableNotifications() async {
    final res = await _requestNotificationInBackground();
    final notifications = <NotificationModel>[];

    for (var i in res) {
      final notification = NotificationModel.fromJson(i);
      if (!notification.isRead) {
        notifications.add(notification);
      }
    }
    return notifications;
  }

  static Future _requestNotificationInBackground() async {
    final dio = await _getDio();

    final res = await dio.post(ApiEndpoints.notifications);
    return res.data['notifications'];
  }

  static Future<Dio> _getDio() async {
    final token = await PreferencesService().getToken();
    await dotenv.load();
    final dio = Dio(defaultDioOptions);
    dio.options.headers = Map.from(defaultHeaders)
      ..addAll({'Authorization': 'Bearer ${token.jwt}'});

    return dio;
  }
}
