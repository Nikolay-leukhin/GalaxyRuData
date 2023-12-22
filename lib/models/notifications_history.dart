import 'package:galaxy_rudata/models/notification.dart';

class NotificationsHistory {
  late List<NotificationModel> notifications;

  NotificationsHistory.fromJson(Map<String, dynamic> json) {
    notifications = [];
    for (var i in json['notifications']) {
      notifications.add(NotificationModel.fromJson(i));
    }
    print('notifications history: $notifications');
  }

  Map<String, dynamic> toJson() => {
        'notifications': List.generate(
            notifications.length, (index) => notifications[index].toJson())
      };

  List<NotificationModel> sortNotifications(
      List<NotificationModel> newNotifications) {
    final List<NotificationModel> sorted = [];
    final List<NotificationModel> outdated = List.from(notifications);

    for (final notification in newNotifications) {
      outdated.removeWhere((e) => e == notification);

      if (_canSendNotification(notification)) {
        sorted.add(notification);
      }

      notification.newSendTime = DateTime.now();
      if (!notifications.contains(notification)) {
        notifications.add(notification);
      }
    }

    _removeOutdatedNotifications(outdated);
    return sorted;
  }

  void _removeOutdatedNotifications(List<NotificationModel> outdated) {
    for (var i in outdated) {
      notifications.removeWhere((e) => e == i);
    }
  }

  bool _canSendNotification(NotificationModel notification) {
    if (!notifications.contains(notification)) return true;

    final savedNotification = _findInHistory(notification.id)!;
    return _checkTimeDifference(savedNotification);
  }

  bool _checkTimeDifference(NotificationModel notification) {
    final currDate = DateTime.now();
    return currDate.difference(notification.lastSend!).inDays > 1;
  }

  NotificationModel? _findInHistory(int id) {
    for (var i in notifications) {
      if (i.id == id) return i;
    }

    return null;
  }
}
