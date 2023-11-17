part of 'enter_seed_cubit.dart';

@immutable
sealed class EnterSeedState {}

final class EnterSeedInitial extends EnterSeedState {}

final class EnterSeedLoading extends EnterSeedState {}

final class EnterSeedFailure extends EnterSeedState {}

final class EnterSeedSuccess extends EnterSeedState {}

