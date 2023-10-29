import 'package:flutter/material.dart';
import 'package:watheq_ecommerce/core/constants/colors.dart';

class PrimaryUnderline extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const PrimaryUnderline({this.height = 0.5, this.width = 30, this.color = colorGrey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}