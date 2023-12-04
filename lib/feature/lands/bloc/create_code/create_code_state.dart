part of 'create_code_cubit.dart';

@immutable
sealed class CreateCodeState {}

final class CreateCodeInitial extends CreateCodeState {}

final class CreateCodeLoading extends CreateCodeState {}

final class CreateCodeSuccess extends CreateCodeState {}

