import 'package:flutter/material.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

import '../../../utils/utils.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/text_fields/access_code_field.dart';

const String _lockMessage =
    'Введите персональный код доступа, чтобы забронировать себе жилье во Вселенной Большого Росреестра. Один код дает возможность бронирования одного жилья.';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final codeController = TextEditingController();

  double turn = 0;
  double top = 25;

  final rotationDuration = const Duration(milliseconds: 900);
  final moveDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final field = Center(
      child: Padding(
        padding: EdgeInsets.only(
            top: size.width * 0.88 < 450 ? size.width * 0.88 / 2.5 : 180),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 200),
          child: AccessCodeField(
              controller: codeController,
              keyboardType: const TextInputType.numberWithOptions(),
              hintText: 'Введите код',
              width: size.width - 100),
        ),
      ),
    );

    turnLock() {
      if (turn == 0) {
        setState(() {
          top = 0;
        });
        Future.delayed(moveDuration).then((value) {
          setState(() {
            turn = 0.13;
          });
        });
      } else {
        setState(() {
          turn = 0;
        });
        Future.delayed(rotationDuration).then((value) {
          setState(() {
            top = 25;
          });
        });
      }

      Future.delayed(rotationDuration + moveDuration,
          () => Navigator.of(context).pushNamed(RouteNames.nftCertificate));
    }

    return MainScaffold(
      isBottomImage: true,
      appBar: MainAppBar.backWallet(
        context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: size.width * 0.69,
                constraints: const BoxConstraints(maxWidth: 500),
                child: Text(
                  _lockMessage,
                  style: size.width < 300
                      ? AppTypography.font16w400
                      : AppTypography.font14w400,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: size.width * 0.725,
                height: size.width,
                constraints:
                    const BoxConstraints(maxWidth: 330, maxHeight: 450),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/images/lock/back.png',
                      ),
                    ),
                    AnimatedPositioned(
                      top: top,
                      left: size.width * 0.725 < 300 ? size.width * 0.108 : 50,
                      duration: moveDuration,
                      child: AnimatedRotation(
                        alignment: const Alignment(0.2, 0.3),
                        curve: Curves.decelerate,
                        turns: turn,
                        duration: rotationDuration,
                        child: Container(
                          constraints: const BoxConstraints(
                              maxWidth: 230, maxHeight: 250),
                          height: size.width * 0.48,
                          width: size.width * 0.51,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/lock/lock.png'),
                                  fit: BoxFit.fitWidth)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/images/lock/front.png',
                      ),
                    ),
                    field
                  ],
                ),
              ),
              CustomButton(
                  content: Text(
                    'Отправить код'.toUpperCase(),
                    style: AppTypography.font16w600,
                  ),
                  onTap: () {
                    turnLock();
                  },
                  width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
