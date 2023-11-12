import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxy_rudata/app.dart';
import 'package:galaxy_rudata/services/custom_bloc_observer.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = CustomBlocObserver();

  await dotenv.load();
  TrustWalletCoreLib.init();

  runApp(const MyRepositoryProvider());
}
