import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/actions_container.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/rf_container.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';

class SafeScreen extends StatefulWidget {
  const SafeScreen({super.key});

  @override
  State<SafeScreen> createState() => _SafeScreenState();
}

class _SafeScreenState extends State<SafeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/auth_background.png"))),
      child: Stack(children: [
        SvgPicture.asset('assets/'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MainAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Поздравляем! Вы получили NFT-сертификат собственного жилья во Вселенной Большого Росреестра!',
                      style: AppTypography.font16w400,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: size.width - 64,
                      height: (size.width - 64) * 0.854,
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
                          image: const DecorationImage(
                            image: AssetImage('assets/images/certificate.png'),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                        content: Text(
                          'Посмотреть в кошельке'.toUpperCase(),
                          style: AppTypography.font16w600,
                        ),
                        onTap: () {},
                        width: double.infinity),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        content: Text(
                          'Забронировать ещё жилье!'.toUpperCase(),
                          style: AppTypography.font16w600,
                        ),
                        onTap: () {},
                        width: double.infinity),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
