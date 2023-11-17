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
      emit(EnterSeedSuccess());
    } catch (e, st) {
      print(st);
      emit(EnterSeedFailure());
    }
  }
}
