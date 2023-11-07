part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String name;

  AuthSuccessState({required this.name});
}

class AuthFailState extends AuthState {}
