import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxy_rudata/services/api/service/background_notifications.dart';
import 'package:galaxy_rudata/services/custom_bloc_observer.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:workmanager/workmanager.dart';

import 'providers.dart';

const gettingNotifications = "gettingNotifications";
final Workmanager wm = Workmanager();




void callbackDispatcher() {
  print('start callback');
  try {
    Workmanager().executeTask((task, inputData) async {
      await BackgroundNotificationsService.backgroundNotificationsTask();
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
