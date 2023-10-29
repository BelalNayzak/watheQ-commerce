import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:watheq_ecommerce/core/constants/font_sizes.dart';
import 'package:watheq_ecommerce/core/constants/spaces.dart';

class OnboardingSlide extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const OnboardingSlide({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 30.h,
          fit: BoxFit.fitHeight,
        ),
        Spaces.vertical50(),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSizes.xxx_large,
          ),
        ),
        Spaces.vertical16(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: FontSizes.medium),
          ),
        ),
        Spaces.vertical50(),
      ],
    );
  }
}