import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:meta/meta.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepository _authRepository;
  final WalletRepository _walletRepository;

  AppCubit(
      {required AuthRepository authRepository,
      required WalletRepository walletRepository})
      : _authRepository = authRepository,
        _walletRepository = walletRepository,
        super(AppInitial()) {
    _authRepository.appState.stream.listen((event) async {
      if (event == AppStateEnum.auth) {
        final walletCreated = await _walletRepository.checkWalletAuth();

        if (walletCreated) {
          await _walletRepository.getWalletInstance();
          
          final currentCode = await _authRepository.currentInviteCode();
          if (currentCode == null) {
            emit(AppAuthState(state: StatesEnum.lockScreen));
          } else{
            if (currentCode.forLandId == null) {
              emit(AppAuthState(state: StatesEnum.landChoseScreen));
            } else {
              emit(AppAuthState(state: StatesEnum.questsScreen));
            }
          }
        } else {
          emit(AppAuthState(state: StatesEnum.createWalletScreen));
        }
        
        
      }
      if (event == AppStateEnum.unAuth) emit(AppUnAuthState());
    });
  }
}
