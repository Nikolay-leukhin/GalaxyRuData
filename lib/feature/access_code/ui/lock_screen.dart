import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';

import '../../../utils/utils.dart';
import '../../../widgets/app_bar_items/actions_container.dart';
import '../../../widgets/app_bar_items/rf_container.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final lockHeight = (size.width - 100) * 334 / 275;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/auth_background.png"))),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: MainAppBar(context,),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _lockMessage,
                    style: AppTypography.font16w400,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: size.width - 100,
                    height: lockHeight,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/access_code_lock.png',
                          width: size.width - 100,
                          height: (size.width - 100) * 334 / 275,
                        ),
                        Center(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: (lockHeight - 60) / 3),
                            child: AccessCodeField(
                                controller: codeController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                hintText: 'Ваш код',
                                width: size.width - 230),
                          ),
                        ),
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
                      onTap: () {},
                      width: double.infinity),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
