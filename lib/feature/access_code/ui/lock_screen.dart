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
  double top = 20;

  final rotationDuration = const Duration(milliseconds: 900);
  final moveDuration = const Duration(milliseconds: 500);

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
          top = 20;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final field = Center(
      child: Padding(
        padding: EdgeInsets.only(
            top: size.width * 0.88 < 425
                ? (size.width * 0.88 - 60) / 2.8
                : 290 / 2.8),
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

    print(size.width);
    return MainScaffold(
      isBottomImage: true,
      appBar: MainAppBar(
        context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size.width * 0.69,
                constraints: const BoxConstraints(maxWidth: 500),
                child: Text(
                  _lockMessage,
                  style: AppTypography.font16w400,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: size.width * 0.725,
                height: size.width,
                constraints:
                    const BoxConstraints(maxWidth: 300, maxHeight: 380),
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
                      duration: moveDuration,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * (0.725 - 0.51) / 2),
                        child: AnimatedRotation(
                          alignment: const Alignment(0.2, 0.3),
                          curve: Curves.decelerate,
                          turns: turn,
                          duration: rotationDuration,
                          child: Container(
                            height: size.width * 0.48,
                            width: size.width * 0.51,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/lock/lock.png'),
                                    fit: BoxFit.fitHeight)),
                          ),
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
              const SizedBox(
                height: 32,
              ),
              CustomButton(
                  content: Text(
                    'Отправить код'.toUpperCase(),
                    style: AppTypography.font16w600,
                  ),
                  onTap: () {
                    turnLock();
                    Navigator.of(context).pushNamed(RouteNames.congratulations);
                  },
                  width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
