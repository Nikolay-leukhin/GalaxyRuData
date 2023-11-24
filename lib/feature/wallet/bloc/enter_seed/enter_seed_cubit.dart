import 'package:bloc/bloc.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:meta/meta.dart';

part 'enter_seed_state.dart';

class EnterSeedCubit extends Cubit<EnterSeedState> {
  final WalletRepository walletRepository;

  EnterSeedCubit(this.walletRepository) : super(EnterSeedInitial());

  void enterSeed(String seedPhrase) async {
    emit(EnterSeedLoading());

    try {
      await walletRepository.enterWalletBySeedPhrase(seedPhrase);
    } catch (e, st) {
      print(e);
      print(st);
      emit(EnterSeedFailure(
          errorText:
              "Такой кошелек не найден в сети Polygon. Попробуйте еще раз."));
      return;
    }

    try {
      await walletRepository.updateWalletAddress();
      await walletRepository.cacheWalletSeed();
      emit(EnterSeedSuccess());
    } catch (ex) {
      emit(EnterSeedFailure(
          errorText:
              "Извините, данный кошелек уже привязан к другому аккаунту"));
    }
  }
}
