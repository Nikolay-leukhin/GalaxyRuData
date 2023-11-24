import 'dart:developer';

import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/services/preferences.dart';
import 'package:galaxy_rudata/utils/utils.dart';
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
    print(seedStorage?[email]);
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
  }

  Future<void> createWallet() async {
    wallet = HDWallet();
    log('try to create wallet');
    print(10000);
    await updateWalletAddress();

    cacheWalletSeed();
  }

  Future cacheWalletSeed() async {
    await prefs.setSeedPhrase(
        seedPhrase: wallet.mnemonic(), email: (await prefs.getEmail())!);

    await prefs.setWalletState(
        WalletCreationState.confirmed, (await prefs.getEmail())!);
  }

  Future setWalletSeedWatchState() async => prefs.setWalletState(
      WalletCreationState.watchSeed, (await prefs.getEmail())!);

  Future setWalletConfirmState() async => prefs.setWalletState(
      WalletCreationState.confirmed, (await prefs.getEmail())!);

  Future<void> updateWalletAddress() async {
    await apiService.wallet.updateWalletAddress(
        wallet.getAddressForCoin(TWCoinType.TWCoinTypePolygon));
  }
}
