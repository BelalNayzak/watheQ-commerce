import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/spaces.dart';

class PrimaryDividerText extends StatelessWidget {
  final String text;

  const PrimaryDividerText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            height: 1,
            color: colorGrey[300],
          ),
        ),
        Spaces.horizontal20(),
        Text(text),
        Spaces.horizontal20(),
        Expanded(
          child: Divider(
            thickness: 1,
            height: 1,
            color: colorGrey[300],
          ),
        )
      ],
    );
  }
}