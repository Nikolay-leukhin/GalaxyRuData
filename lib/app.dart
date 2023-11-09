import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/auth/bloc/app/app_cubit.dart';
import 'package:galaxy_rudata/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:galaxy_rudata/feature/auth/bloc/pin_code/pin_code_cubit.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/login_screen.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/pin_enter_screen.dart';
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
            create: (_) =>
                AuthRepository(apiService: apiService, prefs: prefs)),
      ],
      child: const MyBlocProviders(),
      // child: MyApp(),
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
            return const PinEnterScreen();
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
