import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class BaseTextFormField extends StatefulWidget {
  const BaseTextFormField(
      {Key? key,
      required this.controller,
      required this.keyboardType,
      this.height = 60,
      this.width = double.infinity,
      this.maxLines = 1,
      this.hintText = '',
      this.padding,
      this.obscureText = false,
      this.withError = false,
      this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final double height;
  final double width;
  final int maxLines;
  final String hintText;
  final bool obscureText;
  final bool withError;
  final EdgeInsets? padding;
  final Function? onChanged;

  @override
  State<BaseTextFormField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        maxLines: null,
        keyboardType: widget.keyboardType,
        autofocus: false,
        obscureText: widget.obscureText,
        textAlignVertical: TextAlignVertical.top,
        expands: true,
        decoration: InputDecoration(
          hintStyle: AppTypography.font16w400,
          fillColor: AppColors.textFieldBackground,
          filled: true,
          contentPadding: widget.padding ?? EdgeInsets.symmetric(
                  horizontal: 16, vertical: widget.height / 2 - 16),
          hintText: widget.hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: !widget.withError ? AppColors.silver : Colors.red,
                  width: 1)),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            borderSide: BorderSide(
                color: !widget.withError ? AppColors.silver : Colors.red,
                width: 1),
          ),
        ),
        style: AppTypography.font16w400.copyWith(color: Colors.white),
        onChanged: (String value) {
          if (widget.onChanged != null) {
            widget.onChanged!();
          }
        },
        controller: widget.controller,
      ),
    );
  }
}
