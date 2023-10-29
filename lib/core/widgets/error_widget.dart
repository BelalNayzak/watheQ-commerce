import 'package:watheq_ecommerce/core/constants/assets_refs.dart';
import 'package:flutter/material.dart';

class ErrWidget extends StatelessWidget {
  const ErrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.2,
            child: Image.asset(gif_error),
          ),
          const Text('Oops! something went wrong.'),
        ],
      ),
    );
  }
}