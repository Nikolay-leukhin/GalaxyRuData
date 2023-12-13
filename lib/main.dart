import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/custom_bloc_observer.dart';
import 'package:galaxy_rudata/models/notification.dart';
import 'package:galaxy_rudata/services/notifications.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:workmanager/workmanager.dart';

import 'providers.dart';

const gettingNotifications = "gettingNotifications";
final Workmanager wm = Workmanager();

Future<List<NotificationModel>> _getNotifications() async {
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

void callbackDispatcher() {
  print('start callback');
  try {
    wm.executeTask((task, inputData) async {
      try {
        final notifications = await _getNotifications();

        print('notifications got');

        if (notifications.isNotEmpty) {
          print('initializing notification service');

          final notificationsService = NotificationsService();
          await notificationsService.initializeNotification();

          print('notifications service initialized');

          for (var notification in notifications) {
            print('trying ti show notification $notification');
            notificationsService.showNotification(
                title: 'Новое событие', body: notification.message);
          }
        }
      } catch (e) {
        print(e);
        rethrow;
      }



      return Future.value(true);
    });
  } catch (e) {
    print(e);
    print('execution error');
    rethrow;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = CustomBlocObserver();

  await dotenv.load();
  TrustWalletCoreLib.init();
  await wm.initialize(callbackDispatcher, isInDebugMode: true);
  try {
    await wm.registerPeriodicTask(
        "gettingNotifications", gettingNotifications,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(
          networkType: NetworkType.connected,
        ));
    print('callbackDispatcher registered');

  } catch (e) {
    rethrow;
  }

  runApp(MyRepositoryProviders());
}
