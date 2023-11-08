import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class CustomButton extends StatefulWidget {
  final Widget content;

  final VoidCallback onTap;
  final EdgeInsets padding;

  final double width;
  final double height;

  final bool isActive;

  final double radius;

  final Color color;

  const CustomButton(
      {super.key,
      required this.content,
      required this.onTap,
      required this.width,
      this.isActive = true,
      this.height = 60,
        this.padding = EdgeInsets.zero,
      this.radius = 16,
      this.color = AppColors.blue});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.white)
      ),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Padding(
          padding: widget.padding,
          child: Center(child: widget.content),
        ),
      ),
    );
  }
}
