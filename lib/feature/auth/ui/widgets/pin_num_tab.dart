import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class PinNumTab extends StatelessWidget {
  final Function onTap;
  final Widget content;

  const PinNumTab({
    super.key,
    required this.onTap,
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Ink(
        width: 70,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.pinButton,
            borderRadius: BorderRadius.circular(8),
            border:
            Border.all(width: 1.36, color: AppColors.blue)),
        child: Center(
          child:  content,
        ),
      ),
    );
  }
}


