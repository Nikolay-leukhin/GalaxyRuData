import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/feature/auth/bloc/app/app_cubit.dart';
import 'package:starter/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:starter/feature/auth/data/auth_repository.dart';
import 'package:starter/feature/auth/ui/login_screen.dart';
import 'package:starter/services/api/api_service.dart';
import 'package:starter/services/preferences.dart';

final PreferencesService prefs = PreferencesService();
final ApiService apiService = ApiService(preferencesService: prefs);

class MyRepositoryProvider extends StatelessWidget {
  const MyRepositoryProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (_) => AuthRepository(apiService: apiService)),
        ],
        child: const MyBlocProviders(),
        // child: MyApp(),
      ),
    );
  }
}

class MyBlocProviders extends StatelessWidget {
  const MyBlocProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
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
        ],
        child: const AppStateWidget(),
      ),
    );
  }
}

class AppStateWidget extends StatelessWidget {
  const AppStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AppAuthState) {
            return Scaffold();
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
