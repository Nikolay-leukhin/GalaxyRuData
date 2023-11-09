import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/painters/white_circle.dart';
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 260,
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
                  key: UniqueKey(),
                width: size.width * 0.82,
                height: size.width * 0.86,
                alignment: Alignment.center,
                constraints: const BoxConstraints(maxWidth: 350),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/safe.png'),
                  fit: BoxFit.fitWidth,
                )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      key: UniqueKey(),
                      width: size.width * 0.23,
                      height: size.width * 0.23,
                      constraints: const BoxConstraints(maxWidth: 94, minHeight: 94),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/safe1.png'),
                          fit: BoxFit.fitHeight
                        )
                      ),
                      child: CustomPaint(
                        painter: WhiteCircle(),
                      ),
                    ),
                  ],
                )
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
        ),
      ),
      appBar: MainAppBar(context),
    );
  }
}
