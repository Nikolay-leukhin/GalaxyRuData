import 'package:flutter/cupertino.dart';
import 'package:galaxy_rudata/feature/auth/ui/login_screen.dart';
import 'package:galaxy_rudata/routes/route_names.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  RouteNames.authEnterEmail: (context) => const LoginScreen()
};
