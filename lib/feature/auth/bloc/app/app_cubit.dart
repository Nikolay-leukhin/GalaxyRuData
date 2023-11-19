import 'package:bloc/bloc.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:meta/meta.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

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
        loadWalletAddress();
        emit(AppAuthState());
      }
      if (event == AppStateEnum.unAuth) emit(AppUnAuthState());
    });
  }

  void loadWalletAddress() async {
    if (await _walletRepository.checkWalletAuth()) {
      await _walletRepository.getWalletInstance();
      // _authRepository.logout();
    } else {
      _authRepository.logout();
    }
  }
}
