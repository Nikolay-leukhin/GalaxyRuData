import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';
import 'package:galaxy_rudata/widgets/text_fields/base_text_form_field.dart';

class WalletEnterSeedPhraseScreeen extends StatefulWidget {
  const WalletEnterSeedPhraseScreeen({super.key});

  @override
  State<WalletEnterSeedPhraseScreeen> createState() =>
      WalletEnterSeedPhraseScreenState();
}

class WalletEnterSeedPhraseScreenState
    extends State<WalletEnterSeedPhraseScreeen> {
  final TextEditingController controller = TextEditingController();

  bool isPassButtonActive = false;

  void checkFieldWordsCount(String text) {
    final wordsCount = text.split(" ").length;
    setState(() {
      isPassButtonActive = wordsCount == 12 || wordsCount == 24;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: MainAppBar.onlyLogo(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            Text(
              "Напишите сид-фразу\nчерез пробелы (без запятых)",
              style: AppTypography.font16w400.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 28,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Секретная фраза",
                  style: AppTypography.font16w400.copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: Stack(
                    children: [
                      BaseTextFormField(
                        controller: controller,
                        keyboardType: TextInputType.multiline,
                        height: 260,
                        width: double.infinity,
                        onChanged: () => checkFieldWordsCount(controller.text),
                      ),
                      Positioned(
                          bottom: 15,
                          right: 14,
                          child: CustomButton(
                            borderColor: AppColors.blue1,
                            gradient: AppGradients.radialSky,
                            height: 36,
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/copy_small.svg",
                                  width: 24,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Вставить",
                                  style: AppTypography.font16w500,
                                )
                              ],
                            ),
                            onTap: () async {
                              final copyData =
                                  await Clipboard.getData('text/plain');
                              setState(() {
                                controller.text =
                                    copyData?.text?.toLowerCase() ?? "";
                              });
                              checkFieldWordsCount(controller.text);
                            },
                            width: 141,
                          ))
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            CustomButton(
                isActive: isPassButtonActive,
                content: Text(
                  "Подтвердить".toUpperCase(),
                  style: AppTypography.font16w600.copyWith(
                      color:
                          isPassButtonActive ? Colors.white : AppColors.grey),
                ),
                onTap: () {},
                width: double.infinity),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
