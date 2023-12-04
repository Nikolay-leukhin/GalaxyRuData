import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/feature/games/games_screen.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/pages.dart';
import 'package:galaxy_rudata/feature/wallet/ui/pages/pages.dart';
import 'package:galaxy_rudata/feature/auth/bloc/app/app_cubit.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/login_screen.dart';
import 'package:galaxy_rudata/feature/splash/splash_screen.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void dispose() {
    super.dispose();
    stopPlayer();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();
    checkUpdate();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    RepositoryProvider.of<AudioRepository>(context)
        .handleAppLifecycleStateChanges(state);
  }

  Future<void> stopPlayer() async {
    await RepositoryProvider
        .of<AudioRepository>(context)
        .backgroundPlayer
        .dispose();
  }

  Future checkUpdate() async {
    // print('check update starting');
    //
    // final newVersion = NewVersion();
    // final status = await newVersion.getVersionStatus();
    // if (status != null && status.canUpdate) {
    //   showUpdateDialog(newVersion, status);
    // } else if (status != null) {
    //   print('local version: ${status.localVersion}; store version: ${status.localVersion}');
    // } else {
    //   print('Update status: $status');
    // }
  }

  // void showUpdateDialog(NewVersion newVersion, VersionStatus status) {
  //   newVersion.showUpdateDialog(
  //     context: context,
  //     versionStatus: status,
  //     dialogTitle: 'Новая версия!',
  //     dialogText: 'Для продолжения работы необходимо обновление',
  //     updateButtonText: 'Обновить',
  //     dismissButtonText: 'Выйти',
  //     dismissAction: () {},
  //   );
  // }

  // Future update() async {
  //   await InAppUpdate.performImmediateUpdate();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Вселенная Большого Росреестра',
      builder: (context, child) =>
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          ),
      theme: ThemeData(
        fontFamily: 'Nunito',
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
        }),
      ),
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      initialRoute: RouteNames.root,
    );
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({Key? key}) : super(key: key);

  @override
  State<AppStateWidget> createState() => _AppStateWidgetState();
}

class _AppStateWidgetState extends State<AppStateWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AppAuthState) {
              if (state.state == StatesEnum.lockScreen) {
                return const LockScreen();
              } else if (state.state == StatesEnum.createWalletScreen) {
                return const WalletCreateScreen();
              } else if (state.state == StatesEnum.landChoseScreen) {
                return const ArPlanetViewScreen();
              } else if (state.state == StatesEnum.seedPhraseScreen) {
                return const WalletSeedPhraseScreen(withContinueButton: true);
              } else if (state.state == StatesEnum.walletCreatedScreen) {
                return const WalletCreatedScreen();
              } else {
                // == questsScreen
                return const QuestsScreen();
              }
            } else if (state is AppUnAuthState) {
              return const GamesScreen();
            } else {
              return const SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
