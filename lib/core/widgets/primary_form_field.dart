import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

class PrimaryFormField extends StatelessWidget {
  final String validationError;
  final String label;
  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isPassword;
  final GestureTapCallback? onTap;
  final bool enabled;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool infiniteLines;
  final bool isValidate;
  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final TextDirection? textDirection;

  const PrimaryFormField({
    Key? key,
    required this.validationError,
    required this.label,
    this.controller,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.onTap,
    this.initialValue,
    this.enabled = true,
    this.suffixIcon,
    this.infiniteLines = false,
    this.isValidate = true,
    this.onChange,
    this.inputFormatters,
    this.textAlign,
    this.textDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      onTap: onTap,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection ?? TextDirection.ltr,
      validator: isValidate
          ? (value) {
              if (value!.isEmpty) {
                return validationError;
              }
              return null;
            }
          : null,
      controller: controller,
      obscureText: isPassword,
      maxLines: infiniteLines ? null : 1,
      onChanged: onChange,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: colorGrey,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: colorGrey,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: colorGrey,
          ),
        ),
      ),
    );
  }
}