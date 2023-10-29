import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String content) async {
  if (Platform.isIOS) {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [TextButton(child: const Text('OK'), onPressed: () => Navigator.pop(context))],
      ),
    );
  } else {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [TextButton(child: const Text('OK'), onPressed: () => Navigator.pop(context))],
      ),
    );
  }
}

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
}