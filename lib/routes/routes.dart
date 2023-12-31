import 'package:flutter/material.dart';
import 'package:galaxy_rudata/app_state.dart';
import 'package:galaxy_rudata/feature/games/games_screen.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/pages.dart';
import 'package:galaxy_rudata/feature/wallet/ui/pages/pages.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/pin_enter_screen.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/create_pin_screen.dart';
import 'package:galaxy_rudata/feature/nft/ui/nft_certificate.dart';
import 'package:galaxy_rudata/feature/safe/ui/safe_screen.dart';

part 'route_names.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  RouteNames.root: (context) => const AppStateWidget(),

  RouteNames.nftCertificate: (context) => const NftCertificateScreen(),

  RouteNames.landsUserList: (context) => const UserLandsScreen(),
  RouteNames.cluster: (context) => const ClusterScreen(),

  RouteNames.accessCodeLock: (context) => const LockScreen(),
  RouteNames.quests: (context) => const QuestsScreen(),
  RouteNames.safe: (context) => const SafeScreen(),

  RouteNames.authPinCreate: (context) => const PinCreateFirstScreen(),
  RouteNames.authPinEnter: (context) => const PinEnterScreen(),

  RouteNames.walletSeedPhraseView: (context) =>  const WalletSeedPhraseScreen(withContinueButton: false),
  RouteNames.walletSeedPhrase: (context) =>  const WalletSeedPhraseScreen(withContinueButton: true),
  RouteNames.walletCard: (context) => const WalletCreateScreen(),
  RouteNames.walletEnterSeedPhrase: (context) => const WalletEnterSeedPhraseScreeen(),
  RouteNames.walletCardCreated: (context) => const WalletCreatedScreen(),

  RouteNames.arPlanetView: (context) => const ArPlanetViewScreen(),
  RouteNames.game: (context) => GamesScreen()
};
