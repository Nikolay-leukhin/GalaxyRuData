import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/auth/bloc/app/app_cubit.dart';
import 'package:galaxy_rudata/feature/lands/bloc/blocks.dart';
import 'package:galaxy_rudata/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:galaxy_rudata/feature/auth/bloc/pin_code/pin_code_cubit.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/feature/wallet/bloc/enter_seed/enter_seed_cubit.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'app.dart';

final PreferencesService prefs = PreferencesService();
final ApiService apiService = ApiService(preferencesService: prefs);

class MyRepositoryProviders extends StatelessWidget {
  MyRepositoryProviders({Key? key}) : super(key: key);

  final WalletRepository walletRepository =
      WalletRepository(apiService: apiService, prefs: prefs);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(
              apiService: apiService,
              prefs: prefs,
              walletRepository: walletRepository),
          lazy: false,
        ),
        RepositoryProvider(
          create: (_) => LandsRepository(apiService: apiService),
          lazy: false,
        ),
        RepositoryProvider(
          create: (_) => walletRepository,
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
        BlocProvider<LandsUserCubit>(
          create: (_) => LandsUserCubit(context.read<LandsRepository>()),
          lazy: false,
        ),
        BlocProvider<ConnectLandCubit>(
          create: (_) => ConnectLandCubit(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            landsRepository: RepositoryProvider.of<LandsRepository>(context),
          ),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}
