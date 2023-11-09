part of 'pin_code_cubit.dart';

@immutable
sealed class PinCodeState {}

final class PinCodeInitial extends PinCodeState {}

final class PinCodeRepeatFailure extends PinCodeState {}

final class PinCodeRepeatSuccess extends PinCodeState {}

final class PinCodeEnterFailure extends PinCodeState {}

final class PinCodeEnterSuccess extends PinCodeState {}


