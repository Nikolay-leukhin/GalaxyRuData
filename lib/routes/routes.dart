import 'package:flutter/cupertino.dart';
import 'package:galaxy_rudata/feature/auth/ui/login_screen.dart';
import 'package:galaxy_rudata/feature/certificate/ui/nft_certificate.dart';
import 'package:galaxy_rudata/feature/safe/ui/safe_screen.dart';
import 'package:galaxy_rudata/routes/route_names.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  RouteNames.authEnterEmail: (context) => const LoginScreen(),
  RouteNames.nftCertificate: (context) => const NftCertificateScreen(),
  RouteNames.safe: (context) => const SafeScreen(),
};
