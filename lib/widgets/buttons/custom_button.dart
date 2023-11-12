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

  final Gradient? gradient;

  final Color borderColor;

  const CustomButton(
      {super.key,
      required this.content,
      required this.onTap,
      required this.width,
      this.borderColor = Colors.white,
      this.isActive = true,
      this.height = 60,
      this.padding = EdgeInsets.zero,
      this.radius = 16,
      this.gradient,
      this.color = AppColors.blue});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        widget.onTap();
      },
      child: Ink(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            gradient: widget.gradient,
            color: widget.gradient == null
                ? widget.isActive
                    ? widget.color
                    : AppColors.blueGrey
                : null,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.6, color: widget.isActive ? widget.borderColor : AppColors.grey)),
        child: Padding(
          padding: widget.padding,
          child: Center(child: widget.content),
        ),
      ),
    );
  }
}
