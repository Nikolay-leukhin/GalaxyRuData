import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class DoubleFloatingButton extends StatelessWidget {
  const DoubleFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {},
            child: Ink(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: AppGradients.oceanBlue,
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset('assets/images/info.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {},
            child: Ink(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: AppGradients.oceanBlue,
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset('assets/images/key.png'),
            ),
          ),
        ),
      ],
    );
  }
}