part of 'use_invite_code_cubit.dart';

@immutable
sealed class UseInviteCodeState {}

final class UseInviteCodeInitial extends UseInviteCodeState {}

final class UseInviteCodeLoading extends UseInviteCodeState {}


final class UseInviteCodeFailure extends UseInviteCodeState {}

final class UseInviteCodeSuccess extends UseInviteCodeState {}

