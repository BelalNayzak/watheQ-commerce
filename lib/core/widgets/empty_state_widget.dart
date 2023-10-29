import 'package:watheq_ecommerce/core/constants/assets_refs.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(gif_empty_cart, width: 100),
          const Text('There is no items!'),
        ],
      ),
    );
  }
}