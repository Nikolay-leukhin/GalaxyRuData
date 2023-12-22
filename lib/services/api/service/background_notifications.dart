import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/notification.dart';
import '../../../models/notifications_history.dart';
import '../../notifications.dart';
import '../api_service.dart';
import '../endpoints.dart';

class BackgroundNotificationsService {
  static const String simplePeriodicTaskKey =
      "com.kadastr.rosreestr.periodicNotificationTask";

  static const String _historyKey = 'notifications_history_key';

  static Future<bool> backgroundNotificationsTask() async {
    log('start notification task');
    final notifications = await _getAvailableNotifications();
    if (notifications.isNotEmpty) await _showNotifications(notifications);
    return true;
  }

  static Future<void> markNotificationsAsRead() async {
    final dio = await _getDio();
    final notifications = await _getAvailableNotifications();
    for (NotificationModel notification in notifications) {
      dio.post(ApiEndpoints.readNotification, data: {"id": notification.id});
    }
  }

  static Future _showNotifications(
      List<NotificationModel> notifications) async {
    log('trying to show notifications');
    final notificationsService = NotificationsService();
    await notificationsService.initializeNotification();
    for (var notification in notifications) {
      try {
        await notificationsService.showNotification(
            title: 'Новое событие',
            body: notification.message,
            id: notification.id);
        log('notification ${notification.id} showed');
      } catch (e) {
        log('error $e on showing notification ${notification.id}');
      }
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
    log('trying to sort with history');

    final sorted = await _sortNotificationsWithHistory(notifications);
    return sorted;
  }

  static Future<List<NotificationModel>> _sortNotificationsWithHistory(
      List<NotificationModel> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final res = prefs.getString(_historyKey) ?? '{"notifications": []}';
    log('preferences response: $res');
    log('parsing');
    final history = NotificationsHistory.fromJson(jsonDecode(res));

    log('sorting');
    final sorted = history.sortNotifications(notifications);
    log('sorted list: $sorted');
    final a = history.toJson();
    log('new history json: $a');
    prefs.setString(_historyKey, jsonEncode(a));
    return sorted;
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
      ..addAll({'Authorization': token.bearer});

    return dio;
  }
}
