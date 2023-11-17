
import 'package:flutter/cupertino.dart';
import 'package:galaxy_rudata/app.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/pin_enter_screen.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/pin_repeat_screen.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/pin_screen.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/congratulations_booked_accommodation.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/lock_screen.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/user_lands_list_screen.dart';
import 'package:galaxy_rudata/feature/nft/ui/nft_certificate.dart';
import 'package:galaxy_rudata/feature/lands/ui/pages/lands_list_screen.dart';
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
  RouteNames.landsUserList: (context) => const UserLandsListScreen(),
  
  RouteNames.accessCodeLock: (context) => const LockScreen(),
  RouteNames.congratulations: (context) => const CongratulationsBookedAccommodation(),
  RouteNames.safe: (context) => const SafeScreen(),

  RouteNames.authPinCreate: (context) => const PinScreen(),
  RouteNames.authPinRepeat: (context) => const PinRepeatScreen(),
  RouteNames.authPinEnter: (context) => const PinEnterScreen(),


  RouteNames.walletSeedPhrase: (context) =>  const WalletSeedPhraseScreen(),
  RouteNames.walletCard: (context) => const WalletCardScreen(),
  RouteNames.walletEnterSeedPhrase: (context) => const WalletEnterSeedPhraseScreeen(),
  RouteNames.walletCardCreated: (context) => const WalletCreatedScreen()
};
