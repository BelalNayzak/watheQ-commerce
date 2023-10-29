import 'package:watheq_ecommerce/core/constants/assets_refs.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              gif_board_2,
              width: 140,
            ),
          ),
          const Text('Loading...'),
        ],
      ),
    );
  }
}