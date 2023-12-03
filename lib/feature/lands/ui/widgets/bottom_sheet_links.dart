import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';

class BottomSheetLinks extends StatelessWidget {
  const BottomSheetLinks({super.key});

  @override
  Widget build(BuildContext context) {
    const seperator16 = SizedBox(
      height: 16,
    );

    final size = MediaQuery.sizeOf(context);

    final musicRepository = RepositoryProvider.of<AudioRepository>(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 2),
      decoration: const BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  height: 2,
                  color: AppColors.lightBlue,
                ),
                seperator16,
                Text(
                  'Откройте ссылку в браузере на вашем компьютере',
                  style: AppTypography.font16w400,
                  textAlign: TextAlign.center,
                ),
                seperator16,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 2,
                        color: AppColors.lightBlue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Поделиться',
                        style: AppTypography.font16w400
                            .copyWith(color: AppColors.lightBlueText),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 2,
                        color: AppColors.lightBlue,
                      ),
                    ),
                  ],
                ),
                seperator16,
                CustomButton(
                    gradient: AppGradients.lightBlue,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/copy.svg',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Копировать',
                          style: AppTypography.font16w600,
                        )
                      ],
                    ),
                    height: 36,
                    onTap: () {},
                    width: size.width - 56, audioPlayer: musicRepository.bigButton,),
                seperator16,
                CustomButton(
                  gradient: AppGradients.lightBlue,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/telegram.svg',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Поделиться',
                          style: AppTypography.font16w600,
                        )
                      ],
                    ),
                    height: 36,
                    onTap: () {},
                    width: size.width - 56, audioPlayer: musicRepository.bigButton,),
                seperator16
              ],
            ),
          ),
        ),
      ),
    );
  }
}
