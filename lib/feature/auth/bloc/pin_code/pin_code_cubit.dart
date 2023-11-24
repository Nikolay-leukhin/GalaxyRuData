import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:meta/meta.dart';

part 'pin_code_state.dart';

class PinCodeCubit extends Cubit<PinCodeState> {
  final AuthRepository authRepository;

  PinCodeCubit(this.authRepository) : super(PinCodeInitial());

  Future<void> checkRepeatedPinCode(
      String pinCode, String repeatedPinCode) async {
    if (pinCode == repeatedPinCode) {
      emit(PinCodeRepeatSuccess());
      // await authRepository.savePinCode();
    } else {
      emit(PinCodeRepeatFailure());
    }
  }

  Future savePin (List<int> pin) => authRepository.savePinCode(pin);

  Future<void> checkUserPinCode(String currentPinCode) async {
    final chachedPin = await authRepository.getPinCode();
    print(chachedPin);
    if (chachedPin != currentPinCode) {
      emit(PinCodeEnterFailure());
    } else {
      authRepository.refreshAuthState();
      emit(PinCodeEnterSuccess());
    }
  }
}
