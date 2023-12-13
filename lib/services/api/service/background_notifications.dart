import '../../../models/notification.dart';
import '../../notifications.dart';
import '../api_service.dart';

class BackgroundNotificationsService {
  static Future<List<NotificationModel>> _getNotifications() async {
    final res = await ApiService.getNotificationInBackground();
    final notifications = <NotificationModel>[];

    for (var i in res) {
      final notification = NotificationModel.fromJson(i);
      if (!notification.isRead) {
        notifications.add(notification);
      }
    }
    return notifications;
  }

  static _showNotifications(List<NotificationModel> notifications) async {
    final notificationsService = NotificationsService();
    await notificationsService.initializeNotification();

    print('notifications service initialized');

    for (var notification in notifications) {
      print('trying ti show notification $notification');
      notificationsService.showNotification(
          title: 'Новое событие', body: notification.message);
    }
  }

  static Future backgroundNotificationsTask() async {
    try {
      final notifications = await _getNotifications();
      print('notifications got');
      if (notifications.isNotEmpty) _showNotifications(notifications);
    } catch (e) {
      print(e);
      print('error in notifications');
      rethrow;
    }
  }
}