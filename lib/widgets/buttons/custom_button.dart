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

  const CustomButton(
      {super.key,
      required this.content,
      required this.onTap,
      required this.width,
      this.isActive = true,
      this.height = 60,
      this.padding = EdgeInsets.zero,
      this.radius = 16,
      this.color = AppColors.blue,
      this.gradient});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: widget.isActive ? widget.color : AppColors.blueGrey,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          widget.onTap();
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: widget.gradient,
              border: Border.all(width: 1, color: Colors.white)),
          child: Padding(
            padding: widget.padding,
            child: Center(child: widget.content),
          ),
        ),
      ),
    );
  }
}
