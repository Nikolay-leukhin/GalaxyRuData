import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class CustomButton extends StatefulWidget {
  final String text;

  final VoidCallback onTap;

  final double width;
  final double height;

  final bool isActive;

  final double radius;

  final Color color;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.width,
      this.isActive = true,
      this.height = 55,
      this.radius = 12,
      this.color = AppColors.primary});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 0.50,
              color: widget.isActive ? AppColors.primary : AppColors.disable),
          borderRadius: BorderRadius.circular(widget.radius),
        )),
        child: TextButton(
            onPressed: widget.isActive ? widget.onTap : () {},
            style: TextButton.styleFrom(
                backgroundColor:
                    widget.isActive ? widget.color : AppColors.disableButton,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.radius))),
            child: Text(widget.text, style: AppTypography.font16w400)));
  }
}
