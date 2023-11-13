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
    final size = MediaQuery.sizeOf(context);


    return Container(
      constraints: const BoxConstraints(
        maxWidth: 125
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          onTap();
        },
        child: Ink(
          width: size.width * 0.189,
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.pinButton,
              borderRadius: BorderRadius.circular(8),
              border:
              Border.all(width: 1.36, color: AppColors.primary)),
          child: Center(
            child:  content,
          ),
        ),
      ),
    );
  }
}


