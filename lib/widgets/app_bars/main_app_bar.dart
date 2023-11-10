import 'package:flutter/material.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/back_wallet.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/rf_container.dart';

class MainAppBar extends PreferredSize {


  // MainAppBar(BuildContext context, {super.key, bool isAction = true})
  //     : super(
  //         preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               isAction ? const AppBarActions() : Container(),
  //               const RfContainer()
  //             ],
  //           ),
  //         ),
  //       );

  MainAppBar.back(BuildContext context, {super.key})
      : super(
    preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppBarActions(actions: [
            AppBarButton(onTap: () {
              Navigator.pop(context);
            }, iconName: 'back.svg')
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
            AppBarButton(onTap: () {
              Navigator.pop(context);
            }, iconName: 'back.svg'),
            AppBarButton(onTap: () {
              Navigator.pushNamed(context, RouteNames.wallet);
            }, iconName: 'wallet.svg'),

          ]), const RfContainer()
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
            AppBarButton(onTap: () {
              Navigator.pop(context);
            }, iconName: 'logout.svg'),
            AppBarButton(onTap: () {
              Navigator.pushNamed(context, RouteNames.wallet);
            }, iconName: 'wallet.svg'),
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
        children: [
          RfContainer()
        ],
      ),
    ),
  );
}
