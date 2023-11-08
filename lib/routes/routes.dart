import 'package:flutter/cupertino.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/login_screen.dart';
import 'package:galaxy_rudata/feature/auth/ui/pages/pin_screen.dart';
import 'package:galaxy_rudata/feature/access_code/ui/lock_screen.dart';
import 'package:galaxy_rudata/feature/certificate/ui/nft_certificate.dart';
import 'package:galaxy_rudata/feature/safe/ui/safe_screen.dart';
import 'package:galaxy_rudata/routes/route_names.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  RouteNames.authEnterEmail: (context) => const LoginScreen(),
  RouteNames.root: (context) => const LockScreen(),
  RouteNames.nftCertificate: (context) => const NftCertificateScreen(),
  RouteNames.accessCodeLock: (context) => const LockScreen(),
  RouteNames.safe: (context) => const SafeScreen(),
  RouteNames.authPin: (context) => const PinScreen()
};
