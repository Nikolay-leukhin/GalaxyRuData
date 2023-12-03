import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:meta/meta.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepository _authRepository;
  final WalletRepository _walletRepository;
  final LandsRepository _landsRepository;
  final AudioRepository _audioRepository;

  AppCubit(
      {required AuthRepository authRepository,
      required LandsRepository landsRepository,
      required AudioRepository audioRepository,
      required WalletRepository walletRepository})
      : _authRepository = authRepository,
        _walletRepository = walletRepository,
        _audioRepository = audioRepository,
        _landsRepository = landsRepository,
        super(AppInitial()) {
    _subscribeAuth();
    _subscribeCode();
  }

  void _subscribeAuth() {
    _authRepository.appState.stream.listen((event) async {
      await _audioRepository.initialized; // TODO вернуть перед билдом
      if (event == AppStateEnum.auth) _handleAuthEvent();
      if (event == AppStateEnum.unAuth) emit(AppUnAuthState());
    });
  }

  void _subscribeCode() {
    _landsRepository.codeStates.stream.listen((event) {
      if (event == CodeStates.lock) emit(AppAuthState(state: StatesEnum.lockScreen));
      if (event == CodeStates.choose) emit(AppAuthState(state: StatesEnum.landChoseScreen));
      if (event == CodeStates.quests) emit(AppAuthState(state: StatesEnum.questsScreen));
    });
  }

  void _handleAuthEvent() async {
    final walletCreated = await _walletRepository.checkWalletAuth();
    if (walletCreated) {
      await _walletRepository.getWalletInstance();
      _checkWalletStateAndCode();
    } else {
      emit(AppAuthState(state: StatesEnum.createWalletScreen));
    }
  }

  void _checkWalletStateAndCode() async {
    final walletState = await _authRepository.walletState();

    if (walletState != null) {
      if (walletState == WalletCreationState.created) {
        emit(AppAuthState(state: StatesEnum.walletCreatedScreen));
      } else if (walletState == WalletCreationState.watchSeed) {
        emit(AppAuthState(state: StatesEnum.seedPhraseScreen));
      } else {
        _checkCodeState();
      }
    }
  }

  void _checkCodeState() async {
    final currentCode = await _authRepository.getCurrentInviteCode();
    if (currentCode == null) {
      emit(AppAuthState(state: StatesEnum.lockScreen));
    } else {
      _landsRepository.code = currentCode.code;
      if (currentCode.forLandId == null) {
        emit(AppAuthState(state: StatesEnum.landChoseScreen));
      } else {
        emit(AppAuthState(state: StatesEnum.questsScreen));
      }
    }
  }

  void clearCodeState() {
    _landsRepository.code = null;
    _authRepository.refreshAuthState();
  }
}
