import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class WalletRepository {
  final ApiService apiService;
  final PreferencesService prefs;

  late HDWallet wallet;

  WalletRepository({required this.apiService, required this.prefs});

  Future<bool> checkWalletAuth() async {
    final cachedSeed = await prefs.getSeedPhrase();
    return cachedSeed != null;
  }

  void getWalletInstance() async {
    final cachedSeed = await prefs.getSeedPhrase();
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
