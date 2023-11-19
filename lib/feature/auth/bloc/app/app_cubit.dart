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
        final walletCreated = await _walletRepository.checkWalletAuth();

        if (walletCreated) {
          await _walletRepository.getWalletInstance();
        }
        emit(AppAuthState(walletCreated: walletCreated));
      }
      if (event == AppStateEnum.unAuth) emit(AppUnAuthState());

      if (event == AppStateEnum.createPin) emit(AppCreatePin());
      if (event == AppStateEnum.enterPin) emit(AppEnterPin());
    });
  }
}
