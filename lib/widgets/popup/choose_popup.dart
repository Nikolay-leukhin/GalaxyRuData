import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';

class CustomChoosePopup extends StatelessWidget {
  final VoidCallback onTap;
  final Text message;
  final String confirmText;
  final VoidCallback? onDismiss;

  const CustomChoosePopup(
      {super.key,
      required this.onTap,
      required this.message,
      this.confirmText = 'ОК',
      this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final musicRepository = RepositoryProvider.of<AudioRepository>(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width - 32,
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
              color: AppColors.darkBlue1,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              message,
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      content: Text(confirmText.toUpperCase(),
                          style: AppTypography.font16w600
                              .copyWith(color: Colors.white)),
                      onTap: onTap,
                      width: double.infinity,
                      audioPlayer: musicRepository.mediumButton,
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: CustomButton(
                        content: Text("Отмена".toUpperCase(),
                            style: AppTypography.font16w600
                                .copyWith(color: Colors.white)),
                        onTap: onDismiss ??
                            () {
                              Navigator.pop(context);
                            },
                        width: double.infinity,
                        audioPlayer: musicRepository.mediumButton),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
