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
    final seedStorage = await prefs.getSeedPhrase();
    final email = await prefs.getEmail();

    print('1--------------');
    print(seedStorage);
    print(email);
    return seedStorage?[email] != null;
  }

  Future<void> getWalletInstance() async {
    final seedStorage = await prefs.getSeedPhrase();
    final currentEmail = await prefs.getEmail();
    final currentAccountSeed = seedStorage![currentEmail];

    print('2--------------');
    print(seedStorage);
    wallet = HDWallet.createWithMnemonic(currentAccountSeed!);
  }

  Future<void> enterWalletBySeedPhrase(String seedPhrase) async {
    wallet = HDWallet.createWithMnemonic(seedPhrase);

    await updateWalletAddress();

    await prefs.setSeedPhrase(
        seedPhrase: wallet.mnemonic(), email: (await prefs.getEmail())!);
  }

  Future<void> createWallet() async {
    wallet = HDWallet();

    await updateWalletAddress();

    await prefs.setSeedPhrase(
        seedPhrase: wallet.mnemonic(), email: (await prefs.getEmail())!);
  }

  Future<void> updateWalletAddress() async {
    await apiService.wallet.updateWalletAddress(
        wallet.getAddressForCoin(TWCoinType.TWCoinTypePolygon));
  }
}
