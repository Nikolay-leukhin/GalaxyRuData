
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({super.key, required this.onTap, required this.iconName});

  final VoidCallback onTap;

  /// Указывать не полным путем, а только то что после ...icons/
  /// Например не 'assets/icons/wallet.svg' а wallet.svg
  final String iconName;

  @override
  Widget build(BuildContext context) {
    final maxHeight = min(MediaQuery.sizeOf(context).width / 6, 60).toDouble();

    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(4),
        child: SvgPicture.asset(
          'assets/icons/$iconName',
          width: maxHeight / 1.87,
          height: maxHeight / 1.87,
        ),
      ),
    );
  }
}