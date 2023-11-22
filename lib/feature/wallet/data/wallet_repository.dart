import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class WalletRepository {
  final ApiService apiService;
  final PreferencesService prefs;

  late HDWallet wallet;

  WalletRepository({required this.apiService, required this.prefs});

  Future<bool> get pinCreated async {
    final code = await prefs.getPinCode();
    return code != null;
  }

  Future<bool> walletPinCode() async => await prefs.getPinCode() != null;

  Future<bool> checkWalletAuth() async {
    final cachedSeed = await prefs.getSeedPhrase();
    print('1--------------');
    print(cachedSeed);
    return cachedSeed != null;
  }

  Future<void> getWalletInstance() async {
    final cachedSeed = await prefs.getSeedPhrase();
    print('2--------------');
    print(cachedSeed);
    wallet = HDWallet.createWithMnemonic(cachedSeed!);
  }

  Future<void> enterWalletBySeedPhrase(String seedPhrase) async {
    wallet = HDWallet.createWithMnemonic(seedPhrase);

    await updateWalletAddress();

    await prefs.setSeedPhrase(wallet.mnemonic());
  }

  Future<void> createWallet() async {
    wallet = HDWallet();

    await updateWalletAddress();

    await prefs.setSeedPhrase(wallet.mnemonic());
  }

  Future<void> updateWalletAddress() async {
    await apiService.wallet.updateWalletAddress(
        wallet.getAddressForCoin(TWCoinType.TWCoinTypePolygon));
  }
}
