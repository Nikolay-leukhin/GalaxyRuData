import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'feature/auth/bloc/app/app_cubit.dart';
import 'feature/auth/ui/pages/login_screen.dart';
import 'feature/lands/ui/pages/pages.dart';
import 'feature/splash/splash_screen.dart';
import 'feature/wallet/ui/pages/pages.dart';
import 'utils/utils.dart';
import 'widgets/popup/choose_popup.dart';

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({Key? key}) : super(key: key);

  @override
  State<AppStateWidget> createState() => _AppStateWidgetState();
}

class _AppStateWidgetState extends State<AppStateWidget> {
  @override
  void initState() {
    checkUpdate();
    super.initState();
  }

  Future checkUpdate() async {
    final canUpdate =
    await RepositoryProvider.of<AppCubit>(context).updateAvailable();

    if (canUpdate) showUpdateDialog();
  }

  void showUpdateDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomChoosePopup(
          message: Text(
            'Вышла новая версия! Для продолжения работы необходимо обновление!',
            style: AppTypography.font16w400,
          ),
          onTap: update,
          confirmText: 'обновить',
          onDismiss: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
        ));
  }

  Future update() async {
    if (Platform.isAndroid) {
      launchUrl(Uri.parse("market://details?id=com.kadastr.rosreestr"),
          mode: LaunchMode.externalApplication);
    } else {
      // launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.rosreestr.kadastr'))
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AppAuthState) {
              if (state.state == StatesEnum.lockScreen) {
                return const LockScreen();
              } else if (state.state == StatesEnum.createWalletScreen) {
                return const WalletCreateScreen();
              } else if (state.state == StatesEnum.landChoseScreen) {
                return const ArPlanetViewScreen();
              } else if (state.state == StatesEnum.seedPhraseScreen) {
                return const WalletSeedPhraseScreen(withContinueButton: true);
              } else if (state.state == StatesEnum.walletCreatedScreen) {
                return const WalletCreatedScreen();
              } else {
                // == questsScreen
                return const QuestsScreen();
              }
            } else if (state is AppUnAuthState) {
              return const LoginScreen();
            } else {
              return const SplashScreen();
            }
          },
        ),
      ),
    );
  }
}