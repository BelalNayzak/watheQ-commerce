import 'package:flutter/material.dart';
import 'package:watheq_ecommerce/core/constants/spaces.dart';

import '../constants/assets_refs.dart';
import '../constants/colors.dart';
import '../constants/data.dart';
import '../constants/font_sizes.dart';
import '../constants/fonts.dart';

class AppLogoWidget extends StatelessWidget {
  final Color? color;
  final double? fontSize;

  const AppLogoWidget({this.color, this.fontSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(img_app_logo, width: 25),
        Spaces.horizontal10(),
        Text(
          appName,
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: fontSize ?? FontSizes.medium,
            fontWeight: FontWeight.w700,
            color: color ?? colorBlack,
          ),
        ),
      ],
    );
  }
}