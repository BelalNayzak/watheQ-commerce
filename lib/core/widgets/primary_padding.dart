import 'package:flutter/material.dart';

class PrimaryPadding extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;

  const PrimaryPadding({
    Key? key,
    required this.child,
    this.decoration,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: padding ?? const EdgeInsets.all(20.0),
        decoration: decoration,
        child: child,
      ),
    );
  }
}