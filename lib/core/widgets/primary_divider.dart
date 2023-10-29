import 'package:flutter/material.dart';
import 'package:watheq_ecommerce/core/constants/colors.dart';

class PrimaryDivider extends StatelessWidget {
  final double height;
  final Color color;
  const PrimaryDivider({this.height = 0.5, this.color = colorGrey, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: height,
      height: height,
      color: color,
    );
  }
}