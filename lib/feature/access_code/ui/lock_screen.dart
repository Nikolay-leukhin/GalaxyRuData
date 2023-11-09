import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
                height: size.width * 0.88,
                constraints: const BoxConstraints(maxWidth: 300, maxHeight: 360),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/access_code_lock.png',
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: size.width * 0.88 < 425
                                ? (size.width * 0.88 - 60) / 2.8
                                : 290 / 2.8),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: AccessCodeField(
                              controller: codeController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              hintText: 'Введите код',
                              width: size.width - 100),
                        ),
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
    );
  }
}
