import 'package:flutter/material.dart';
import 'package:galaxy_rudata/app.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/pin_enter_screen.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/pin_repeat_screen.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/pin_screen.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/quests_screen.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/lock_screen.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/user_lands_screen.dart';
import 'package:galaxy_rudata/feature/nft/ui/nft_certificate.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/lands_list_screen.dart';
import 'package:galaxy_rudata/feature/planet_view/ui/plannet_view_screen.dart';
import 'package:galaxy_rudata/feature/safe/ui/safe_screen.dart';
import 'package:galaxy_rudata/feature/wallet/ui/pages/card_screen.dart';
import 'package:galaxy_rudata/feature/wallet/ui/pages/seed_phrase/enter_seed_phrase_screen.dart';
import 'package:galaxy_rudata/feature/wallet/ui/pages/seed_phrase/seed_phrase_screen.dart';
import 'package:galaxy_rudata/feature/wallet/ui/pages/wallet_created_screen.dart';
import 'package:galaxy_rudata/routes/route_names.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  RouteNames.root: (context) => const AppStateWidget(),

  RouteNames.nftCertificate: (context) => const NftCertificateScreen(),

  RouteNames.landsList: (context) => const LandsListScreen(),
  RouteNames.landsUserList: (context) => const UserLandsScreen(),
  
  RouteNames.accessCodeLock: (context) => const LockScreen(),
  RouteNames.quests: (context) => const QuestsScreen(),
  RouteNames.safe: (context) => const SafeScreen(),

  RouteNames.authPinCreate: (context) => const PinCreateFirstScreen(),
  RouteNames.authPinRepeat: (context) => const PinRepeatScreen(),
  RouteNames.authPinEnter: (context) => const PinEnterScreen(),


  RouteNames.walletSeedPhraseView: (context) =>  const WalletSeedPhraseScreen(withContinueButton: false),
  RouteNames.walletSeedPhrase: (context) =>  const WalletSeedPhraseScreen(withContinueButton: true),
  RouteNames.walletCard: (context) => const WalletCreateScreen(),
  RouteNames.walletEnterSeedPhrase: (context) => const WalletEnterSeedPhraseScreeen(),
  RouteNames.walletCardCreated: (context) => const WalletCreatedScreen(),

  RouteNames.arPlanetView: (context) => const ArPlanetViewScreen(),
};
