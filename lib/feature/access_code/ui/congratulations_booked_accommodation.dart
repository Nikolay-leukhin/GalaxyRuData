import 'package:flutter/material.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

const String _congratulationsMessage =
    'Чтобы получить NFT-сертификат, пройдите квесты на космической базе Большого Росреестра в метавселенной Spatial. Вы можете сделать это как с телефона, так и на компьютере.';

class CongratulationsBookedAccommodation extends StatefulWidget {
  const CongratulationsBookedAccommodation({super.key});

  @override
  State<CongratulationsBookedAccommodation> createState() =>
      _CongratulationsBookedAccommodationState();
}

class _CongratulationsBookedAccommodationState
    extends State<CongratulationsBookedAccommodation> {
  final separate = const SizedBox(
    height: 32,
  );

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        appBar: MainAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Поздравляем, вы забронировали жилье!',
                  textAlign: TextAlign.center,
                  style: AppTypography.font24w700,
                ),
                separate,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    _congratulationsMessage,
                    style: AppTypography.font16w400,
                    textAlign: TextAlign.center,
                  ),
                ),
                separate,
                CustomButton(
                    content: Text(
                      'Квесты на компьютере'.toUpperCase(),
                      style: AppTypography.font16w400,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.walletSeedPhrase);
                    },
                    width: double.infinity),
                separate,
                CustomButton(
                    content: Text(
                      'Квесты на телефоне'.toUpperCase(),
                      style: AppTypography.font16w400,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.nftCertificate);
                    },
                    width: double.infinity),
                separate,
                CustomButton(
                    content: Text(
                      'Я уже прошел квесты!'.toUpperCase(),
                      style: AppTypography.font16w400,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.safe);
                    },
                    width: double.infinity),
              ],
            ),
          ),
        ));
  }
}
