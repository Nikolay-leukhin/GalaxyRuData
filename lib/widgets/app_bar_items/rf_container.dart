import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RfContainer extends StatelessWidget {
  const RfContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final maxHeight = min(MediaQuery.sizeOf(context).width / 6, 60).toDouble();

    return SizedBox(
        height: maxHeight,
        child: SizedBox(
            height: maxHeight - maxHeight / 6,
            child: SvgPicture.asset('assets/icons/rf.svg')));
  }
}
