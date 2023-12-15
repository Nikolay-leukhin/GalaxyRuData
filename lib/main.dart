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

@pragma('vm:entry-point')
void callbackDispatcher() {
  print('start callback');
  Workmanager().executeTask((task, inputData) async {
    await BackgroundNotificationsService.backgroundNotificationsTask();
    // print('Execution successful');
    return Future.value(true);
  });
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
  print('workmanager initialized');
  await wm.registerPeriodicTask(
      "rosreestrGettingNotifications", gettingNotifications,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  print('callbackDispatcher registered');
  // await BackgroundNotificationsService.backgroundNotificationsTask();

  runApp(MyRepositoryProviders());
}
