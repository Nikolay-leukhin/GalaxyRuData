import 'package:flutter/material.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

class WalletCardScreen extends StatefulWidget {
  const WalletCardScreen({super.key});

  @override
  State<WalletCardScreen> createState() => _WalletCardScreenState();
}

class _WalletCardScreenState extends State<WalletCardScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return MainScaffold(
      appBar: MainAppBar.logoutWallet(context),
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
                    "Подключите цифровой кошелек, после прохождения квестов на него будет отправлен NFT-сертификат вашего жилья во Вселенной  Большого Росреестра",
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
                    image: AssetImage('assets/images/bank_card.png'),
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
                      'Создать кошелек'.toUpperCase(),
                      style: AppTypography.font16w600,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.walletSeedPhrase);
                    },
                    width: double.infinity),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                    content: Text(
                      'Ввести сид-фразу'.toUpperCase(),
                      style: AppTypography.font16w600,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.walletEnterSeedPhrase);
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
