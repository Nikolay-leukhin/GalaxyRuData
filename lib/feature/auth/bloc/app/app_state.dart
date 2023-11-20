part of 'app_cubit.dart';

enum StatesEnum { createWalletScreen, lockScreen, landChoseScreen, questsScreen }

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppCreatePin extends AppState {}

class AppEnterPin extends AppState {}

class AppAuthState extends AppState {
  final StatesEnum state;

  AppAuthState({required this.state});
}

class AppUnAuthState extends AppState {}
