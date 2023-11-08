import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/actions_container.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/rf_container.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

class SafeScreen extends StatefulWidget {
  const SafeScreen({super.key});

  @override
  State<SafeScreen> createState() => _SafeScreenState();
}

class _SafeScreenState extends State<SafeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return MainScaffold(
      isBottomImage: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Text(
                    'Чтобы забрать ваш\nNFT-сертификат, введите код, полученный вами после прохождения квестов на космической базе Большого Росреестр',
                    style: AppTypography.font16w400,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: size.width - 64,
                  height: (size.width - 64) * 0.854,
                  color: Colors.blueAccent,
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                    content: Text(
                      'Отправить код'.toUpperCase(),
                      style: AppTypography.font16w600,
                    ),
                    onTap: () {},
                    width: size.width * 0.528),
              ],
            ),
          ],
        ),
      ),
      appBar: MainAppBar(context,),
    );
  }
}
