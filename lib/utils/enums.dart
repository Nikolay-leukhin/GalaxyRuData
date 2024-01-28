part of 'utils.dart';

enum LoadingStateEnum { wait, loading, success, fail }

enum AppStateEnum { wait, unAuth, auth, enterPin, createPin }

enum WalletCreationState { created, watchSeed, confirmed }

enum StatesEnum {
  createWalletScreen,
  lockScreen,
  landChoseScreen,
  questsScreen,
  walletCreatedScreen,
  seedPhraseScreen
}
