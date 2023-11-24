import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

class WalletCreatedScreen extends StatefulWidget {
  const WalletCreatedScreen({super.key});

  @override
  State<WalletCreatedScreen> createState() => _WalletCreatedScreenState();
}

class _WalletCreatedScreenState extends State<WalletCreatedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return MainScaffold(
      canPop: false,
      appBar: MainAppBar.logout(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 320,
                  child: Text(
                    "Цифровой кошелек успешно создан. Не забудьте записать сид-фразу, чтобы всегда иметь возможность восстановить свой кошелек.",
                    style: AppTypography.font16w400,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: size.width * 0.86,
                  constraints: const BoxConstraints(maxWidth: 350),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/card_success.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                CustomButton(
                    content: Text(

                      'Посмотреть сид-фразу'.toUpperCase(),
                      style: AppTypography.font16w600,
                    ),
                    onTap: () {
                      RepositoryProvider.of<WalletRepository>(context)
                          .setWalletSeedWatchState();
                      Navigator.pushNamed(
                          context, RouteNames.walletSeedPhrase);
                    },
                    width: double.infinity),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                    content: Text(
                      'запишу позже'.toUpperCase(),
                      style: AppTypography.font16w600,
                    ),
                    onTap: () {
                      RepositoryProvider.of<WalletRepository>(context).setWalletConfirmState();
                      RepositoryProvider.of<AuthRepository>(context).refreshAuthState();
                      Navigator.popUntil(
                          context, ModalRoute.withName(RouteNames.root));
                    },
                    width: double.infinity),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
