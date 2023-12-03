import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/app_bar_actions_container.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/app_bar_button.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/rf_container.dart';
import 'package:galaxy_rudata/widgets/popup/choose_popup.dart';

class MainAppBar extends PreferredSize {
  static void _walletFunction(context) {
    RepositoryProvider.of<WalletRepository>(context)
        .pinCreated
        .then((value) {
      Navigator.pushNamed(
          context,
          value
              ? RouteNames.authPinEnter
              : RouteNames.authPinCreate,
          arguments: {
            'confirmation': () {
              Navigator.pushReplacementNamed(
                  context, RouteNames.landsUserList);
            }
          });
    });
  }

  MainAppBar.back(BuildContext context, {super.key})
      : super(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarActions(actions: [
                  AppBarButton(
                      onTap: () {
                        final musicRepository = RepositoryProvider.of<AudioRepository>(context);
                        musicRepository.play(musicRepository.screenChangeSlide);
                        Navigator.pop(context);
                      },
                      iconName: 'back.svg')
                ]),
                const RfContainer()
              ],
            ),
          ),
        );

  MainAppBar.backWallet(BuildContext context, {super.key})
      : super(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarActions(actions: [
                  AppBarButton(
                      onTap: () {
                        final musicRepository = RepositoryProvider.of<AudioRepository>(context);
                        musicRepository.play(musicRepository.screenChangeSlide);
                        Navigator.pop(context);
                      },
                      iconName: 'back.svg'),
                  AppBarButton(
                      onTap: () {
                        _walletFunction(context);
                      },
                      iconName: 'wallet.svg'),
                ]),
                const RfContainer()
              ],
            ),
          ),
        );

  MainAppBar.logoutWallet(BuildContext context, {super.key})
      : super(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarActions(actions: [
                  AppBarButton(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) => CustomLogOutPopup(onTap: () {
                                  context.read<AuthRepository>().logout();
                                  Navigator.popUntil(context,
                                      ModalRoute.withName(RouteNames.root));
                                }));
                      },
                      iconName: 'logout.svg'),
                  AppBarButton(
                      onTap: () {
                        _walletFunction(context);
                      },
                      iconName: 'wallet.svg'),
                ]),
                const RfContainer()
              ],
            ),
          ),
        );

  MainAppBar.logout(BuildContext context, {super.key})
      : super(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarActions(actions: [
                  AppBarButton(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) => CustomLogOutPopup(onTap: () {
                                  context.read<AuthRepository>().logout();
                                  Navigator.popUntil(context,
                                      ModalRoute.withName(RouteNames.root));
                                }));
                      },
                      iconName: 'logout.svg'),
                ]),
                const RfContainer()
              ],
            ),
          ),
        );

  MainAppBar.onlyLogo(BuildContext context, {super.key})
      : super(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [RfContainer()],
            ),
          ),
        );
}
