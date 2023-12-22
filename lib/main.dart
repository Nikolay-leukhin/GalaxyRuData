import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxy_rudata/services/api/service/background_notifications.dart';
import 'package:galaxy_rudata/services/custom_bloc_observer.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:workmanager/workmanager.dart';

import 'providers.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
   final bool result = await  BackgroundNotificationsService.backgroundNotificationsTask();
    return Future.value(result);
  });
}

void initializeWorkmanager() async {
  Workmanager().cancelAll();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  Workmanager().registerPeriodicTask(
      BackgroundNotificationsService.simplePeriodicTaskKey,
      BackgroundNotificationsService.simplePeriodicTaskKey,
      initialDelay: const Duration(seconds: 15),
      frequency: const Duration(minutes: 30),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
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

  initializeWorkmanager();
  BackgroundNotificationsService.markNotificationsAsRead();

  runApp(MyRepositoryProviders());
}
