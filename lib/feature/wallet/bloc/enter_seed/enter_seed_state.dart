part of 'enter_seed_cubit.dart';

@immutable
sealed class EnterSeedState {}

final class EnterSeedInitial extends EnterSeedState {}

final class EnterSeedLoading extends EnterSeedState {}

final class EnterSeedFailure extends EnterSeedState {
  final String errorText;

  EnterSeedFailure({required this.errorText});
}

final class EnterSeedSuccess extends EnterSeedState {}
