// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:galaxy_rudata/utils/utils.dart';

class BaseTextFormField extends StatefulWidget {
  const BaseTextFormField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.height = 76,
    this.width = double.infinity,
    this.maxLines = 1,
    this.hintText = '',
    this.obscureText = false, this.withError = false,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final double height;
  final double width;
  final int maxLines;
  final String hintText;
  final bool obscureText;
  final bool withError;

  @override
  State<BaseTextFormField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      autofocus: false,
      obscureText: widget.obscureText,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintStyle: AppTypography.font16w400,
        fillColor: Colors.black.withOpacity(0.20000000298023224),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: widget.height / 2 - 20),
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: !widget.withError ? AppColors.silver : Colors.red, width: 1)
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          borderSide: BorderSide(
            color: !widget.withError ? AppColors.silver : Colors.red,
            width: 1
          ),
        ),
      ),
      style: AppTypography.font16w400.copyWith(color: Colors.white),
      onChanged: (String value) {
        setState(() {});
      },
      controller: widget.controller,
    );
  }
}
