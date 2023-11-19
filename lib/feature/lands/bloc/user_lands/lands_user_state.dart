part of 'lands_user_cubit.dart';

@immutable
sealed class LandsUserState {}

final class LandsUserInitial extends LandsUserState {}

final class LandsUserLoading extends LandsUserState {}

final class LandsUserSuccess extends LandsUserState {}

final class LandsUserFailure extends LandsUserState {}

