import 'package:flutter/material.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

class NftCertificateScreen extends StatefulWidget {
  const NftCertificateScreen({super.key});

  @override
  State<NftCertificateScreen> createState() => _NftCertificateScreenState();
}

class _NftCertificateScreenState extends State<NftCertificateScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return MainScaffold(
      appBar: MainAppBar.logoutWallet(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 320,
                  child: Text(
                    'Поздравляем! Вы получили NFT-сертификат собственного жилья во Вселенной Большого Росреестра!',
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/certificate.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CustomButton(
                    content: Text(
                      'Посмотреть в кошельке'.toUpperCase(),
                      style: AppTypography.font16w600,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.authPinEnter);
                    },
                    width: double.infinity),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                    content: Text(
                      'Забронировать ещё жилье!'.toUpperCase(),
                      style: AppTypography.font16w600,
                    ),
                    onTap: () {
                      print("DEVELOPING...");
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
