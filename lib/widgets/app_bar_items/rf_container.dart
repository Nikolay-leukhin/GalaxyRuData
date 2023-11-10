import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RfContainer extends StatelessWidget {
  const RfContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: SizedBox(
            height: 50, child: SvgPicture.asset('assets/icons/rf.svg')));
  }
}
