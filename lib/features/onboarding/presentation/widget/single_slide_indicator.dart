import 'package:flutter/material.dart';
import 'package:watheq_ecommerce/core/constants/colors.dart';

class SingleSlideIndicator extends StatelessWidget {
  final bool isActive;

  const SingleSlideIndicator({required this.isActive, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? colorPrimary : colorGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}