import 'package:watheq_ecommerce/core/constants/assets_refs.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(gif_no_internet),
        const Text('Oops! no internet connection.'),
      ],
    );
  }
}