import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class PinCodeIndicatorItem extends StatefulWidget {
  final bool isActive;
  const PinCodeIndicatorItem({super.key, required this.isActive});

  @override
  State<PinCodeIndicatorItem> createState() => _PinCodeIndicatorItemState();
}

class _PinCodeIndicatorItemState extends State<PinCodeIndicatorItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: widget.isActive ? AppGradients.pinIndicatorGradient : LinearGradient(colors: [Colors.white, Colors.white])
      ),
    );
  }
}
