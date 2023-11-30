import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';

class BottomSheetSpatial extends StatelessWidget {
  const BottomSheetSpatial({super.key});

  @override
  Widget build(BuildContext context) {
    const seperator16 = SizedBox(
      height: 16,
    );

    final musicRepository = RepositoryProvider.of<MusicRepository>(context);

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
                  'Нажмите кнопку. Если приложение метавселенной Spatial еще не установлено, то сначала вам будет предложено его скачать.',
                  style: AppTypography.font16w400,
                  textAlign: TextAlign.center,
                ),
                seperator16,
                CustomButton(
                  content: Text(
                    'Spatial',
                    style: AppTypography.font16w600,
                  ),
                  onTap: () {},
                  width: double.infinity,
                  gradient: AppGradients.lightBlue,
                  audioPlayer: musicRepository.bigButton,
                ),
                seperator16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
