import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class AccessCodeField extends StatefulWidget {
  const AccessCodeField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.height = 60,
    this.width,
    this.maxLines = 1,
    this.hintText = '',
    this.padding,
    this.obscureText = false,
    this.withError = false, this.initialValue,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final double height;
  final double? width;
  final int maxLines;
  final String hintText;
  final bool obscureText;
  final bool withError;
  final String? initialValue;
  final EdgeInsets? padding;

  @override
  State<AccessCodeField> createState() => _AccessCodeFieldState();
}

class _AccessCodeFieldState extends State<AccessCodeField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        initialValue: widget.initialValue,
        cursorColor: Colors.white,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        autofocus: false,
        obscureText: widget.obscureText,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintStyle: AppTypography.font16w400,
          fillColor: AppColors.textFieldBackground,
          filled: true,
          contentPadding: widget.padding ?? const EdgeInsets.symmetric(
              horizontal: 16, vertical: 20),
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
        style: AppTypography.font16w400,
        textAlign: TextAlign.center,
        onChanged: (String value) {
          setState(() {});
        },
        controller: widget.controller,
      ),
    );
  }
}
