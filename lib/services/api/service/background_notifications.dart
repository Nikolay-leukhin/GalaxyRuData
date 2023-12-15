import 'package:dio/dio.dart';
import 'package:galaxy_rudata/services/api/service/models/token_model.dart';
import 'package:galaxy_rudata/services/preferences.dart';

import '../../../models/notification.dart';
import '../../notifications.dart';
import '../api_service.dart';
import '../endpoints.dart';

class BackgroundNotificationsService {
  static Future _getNotificationInBackground() async {
    Token token = Token.zero();
    try {
      token = await PreferencesService().getToken();
    } catch (e) {
      print('preferences error');
    }

    final dio = Dio(defaultDioOptions);
    dio.options.headers = Map.from(defaultHeaders)
      ..addAll({'Authorization': 'Bearer ${token.jwt}'});

    print('Dio background headers: ${dio.options.headers}');

    try {
      final res = await dio.post(ApiEndpoints.notifications);

      return res.data['notifications'];
    } catch (e) {
      print('request error');
      rethrow;
    }
  }

  static Future<List<NotificationModel>> _getNotifications() async {
    final res = await _getNotificationInBackground();
    final notifications = <NotificationModel>[];

    for (var i in res) {
      final notification = NotificationModel.fromJson(i);
      if (!notification.isRead) {
        notifications.add(notification);
      }
    }
    print('notifications length: ${notifications.length}');
    return notifications;
  }

  static _showNotifications(List<NotificationModel> notifications) async {
    final notificationsService = NotificationsService();
    await notificationsService.initializeNotification();

    print('notifications service initialized');

    for (var notification in notifications) {
      print('trying to show notification $notification');
      await notificationsService.showNotification(
          title: 'Новое событие',
          body: notification.message,
          id: notification.id);
      print('notification ${notification.id} must be sent');
    }
  }

  static Future backgroundNotificationsTask() async {
    final notifications = await _getNotifications();

    print('notifications got');
    try {
      if (notifications.isNotEmpty) _showNotifications(notifications);
    } catch (e) {
      print('error in showing notifications');
    }
  }
}
