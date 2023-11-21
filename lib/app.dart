import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/auth/bloc/app/app_cubit.dart';
import 'package:galaxy_rudata/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:galaxy_rudata/feature/auth/bloc/pin_code/pin_code_cubit.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/login_screen.dart';
import 'package:galaxy_rudata/feature/lands/bloc/lands_free/lands_free_cubit.dart';
import 'package:galaxy_rudata/feature/lands/bloc/use_invite_code/use_invite_code_cubit.dart';
import 'package:galaxy_rudata/feature/lands/bloc/user_lands/lands_user_cubit.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/lands_list_screen.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/lock_screen.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/quests_screen.dart';
import 'package:galaxy_rudata/feature/planet_view/ui/plannet_view_screen.dart';
import 'package:galaxy_rudata/feature/splash/splash_screen.dart';
import 'package:galaxy_rudata/feature/wallet/bloc/enter_seed/enter_seed_cubit.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:galaxy_rudata/feature/wallet/ui/pages/card_screen.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:just_audio/just_audio.dart';

final PreferencesService prefs = PreferencesService();
final ApiService apiService = ApiService(preferencesService: prefs);

class MyRepositoryProvider extends StatelessWidget {
  const MyRepositoryProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(apiService: apiService, prefs: prefs),
          lazy: false,
        ),
        RepositoryProvider(
          create: (_) => LandsRepository(apiService: apiService, prefs: prefs),
          lazy: false,
        ),
        RepositoryProvider(
          create: (_) => WalletRepository(apiService: apiService, prefs: prefs),
          lazy: false,
        ),
      ],
      child: const MyBlocProviders(),
    );
  }
}

class MyBlocProviders extends StatelessWidget {
  const MyBlocProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (_) => AppCubit(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            landsRepository: RepositoryProvider.of<LandsRepository>(context),
            walletRepository: RepositoryProvider.of<WalletRepository>(context),
          ),
          lazy: false,
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
          lazy: false,
        ),
        BlocProvider<PinCodeCubit>(
          create: (_) => PinCodeCubit(
            RepositoryProvider.of<AuthRepository>(context),
          ),
          lazy: false,
        ),
        BlocProvider<UseInviteCodeCubit>(
          create: (_) => UseInviteCodeCubit(
            RepositoryProvider.of<LandsRepository>(context),
          ),
          lazy: false,
        ),
        BlocProvider<EnterSeedCubit>(
          create: (_) => EnterSeedCubit(context.read<WalletRepository>()),
          lazy: false,
        ),
        BlocProvider<LandsFreeCubit>(
          create: (_) => LandsFreeCubit(context.read<LandsRepository>()),
          lazy: false,
        ),
        BlocProvider<LandsUserCubit>(
          create: (_) => LandsUserCubit(context.read<LandsRepository>()),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  late AudioPlayer player;

  @override
  void dispose() {
    super.dispose();

    player.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        await player.play();
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        await player.stop();
        print("app in resumed");
        break;
      case AppLifecycleState.paused:
        await player.stop();
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        await player.stop();
        print("app in detached");
        break;
      case AppLifecycleState.hidden:
        await player.stop();
        print("app in hidden");
    }
  }

  Future<void> initBackgroundMusic() async {
    player = AudioPlayer();

    await player.setAsset("assets/musics/fist_background.wav");
    await player.play();
    player.playerStateStream.listen((event) async {
      print(event.processingState);

      switch (event.processingState) {
        case ProcessingState.completed:
          await player.setAsset("assets/musics/loop_background.wav");
          await player.play();
        case ProcessingState.idle:
        // TODO: Handle this case.
        case ProcessingState.loading:
        // TODO: Handle this case.
        case ProcessingState.buffering:
        // TODO: Handle this case.
        case ProcessingState.ready:
        // TODO: Handle this case.
      }
    });
  }

  Future<void> stopPlayer() async {
    await player.dispose();
  }

  @override
  void initState() {
    super.initState();

    initBackgroundMusic();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Росреестор',
      theme: ThemeData(
        fontFamily: 'Nunito',
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
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is AppAuthState) {
              if (state.state == StatesEnum.lockScreen) {
                return const LockScreen();
              } else if (state.state == StatesEnum.createWalletScreen) {
                return const WalletCreateScreen();
              } else if (state.state == StatesEnum.landChoseScreen) {
                return const ArPlanetViewScreen();
              } else {
                // == questsScreen
                return const QuestsScreen();
              }
            } else if (state is AppUnAuthState) {
              return const LoginScreen();
            } else {
              return const SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
