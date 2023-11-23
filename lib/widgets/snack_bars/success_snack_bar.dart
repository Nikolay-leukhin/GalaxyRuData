import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class AppSnackBar {
  static final SnackBar successSnackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/verified.svg',
              width: 30,
              height: 30,
            ),
            Text(
              'Сид-фраза скопирована',
              style: AppTypography.font16w600.copyWith(
                fontWeight: FontWeight.w700,
                foreground: Paint()
                  ..shader = AppGradients.oceanBlue
                      .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              ),
            )
          ],
        )),
  );

  static final SnackBar successCopyWallet = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/verified.svg',
              width: 30,
              height: 30,
            ),
            Text(
              'Адрес скопирован',
              style: AppTypography.font16w600.copyWith(
                fontWeight: FontWeight.w700,
                foreground: Paint()
                  ..shader = AppGradients.oceanBlue
                      .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              ),
            )
          ],
        )),
  );
}
