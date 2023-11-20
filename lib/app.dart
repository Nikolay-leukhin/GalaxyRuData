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
import 'package:galaxy_rudata/feature/wallet/bloc/enter_seed/enter_seed_cubit.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:galaxy_rudata/feature/wallet/ui/pages/card_screen.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';

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
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

class AppStateWidget extends StatelessWidget {
  const AppStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return const LandsListScreen();
            } else { // == questsScreen
              return const QuestsScreen();
            }
          } else if (state is AppUnAuthState) {
            return const LoginScreen();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
