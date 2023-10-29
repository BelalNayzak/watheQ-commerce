import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  void push(Widget page) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop() {
    Navigator.of(this).pop();
  }

  void popUntilRoot() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  void pushNamedAndRemoveAll(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false, // This predicate always returns false, removing all routes
      arguments: arguments,
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}