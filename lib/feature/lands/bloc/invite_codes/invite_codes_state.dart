part of 'invite_codes_cubit.dart';

@immutable
sealed class InviteCodesState {}

final class UseInviteCodeInitial extends InviteCodesState {}

final class LoadingState extends InviteCodesState {}


final class UseInviteCodeFail extends InviteCodesState {
  final Exception e;
  UseInviteCodeFail(this.e);
}

final class UseInviteCodeSuccess extends InviteCodesState {}


final class ConnectLandSuccess extends InviteCodesState {}

final class ConnectLandFail extends InviteCodesState {}

final class SafeSuccess extends InviteCodesState {}

final class SafeFail extends InviteCodesState {
  final Exception e;
  SafeFail(this.e);
}