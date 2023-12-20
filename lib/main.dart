import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxy_rudata/services/api/service/background_notifications.dart';
import 'package:galaxy_rudata/services/custom_bloc_observer.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:workmanager/workmanager.dart';

import 'providers.dart';

const simplePeriodicTask =
    "be.tramckrijte.workmanagerExample.simplePeriodicTask6";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await BackgroundNotificationsService.backgroundNotificationsTask();
    return Future.value(true);
  });
}

void initializeWorkmanager() async {
  Workmanager().cancelAll();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(simplePeriodicTask, simplePeriodicTask,
      initialDelay: const Duration(seconds: 15),
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
  // BackgroundNotificationsService.markNotificationsAsRead();

  runApp(MyRepositoryProviders());
}
