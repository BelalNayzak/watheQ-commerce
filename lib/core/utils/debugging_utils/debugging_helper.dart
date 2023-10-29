import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Function to print the very long strings for debugging purposes.
void debugPrinterFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrinter(match.group(0)!));
}

// Function to print a message with a timestamp for debugging purposes.
void debugPrinter(String message) {
  final timestamp = DateTime.now().toLocal();
  print('-----------> [$timestamp] $message');
}

// Function to assert a condition and print a message if it's false.
void debugAssert(bool condition, String message) {
  if (!condition) {
    debugPrinter('Assertion failed: $message');
    assert(condition, message);
  }
}

// Function to log the values of variables for debugging.
void debugLogVariables(Map<String, dynamic> variables) {
  for (var key in variables.keys) {
    debugPrinter('$key: ${variables[key]}');
  }
}

// Function to log the list values for debugging.
void debugPrinterList<T>(List<T> list) {
  for (var i = 0; i < list.length; i++) {
    debugPrinter('[$i]: ${list[i]}');
  }
}

// Function to log the map values for debugging.
void debugPrinterMap<T>(Map<String, T> map) {
  for (var element in map.entries) {
    debugPrinter('${element.key}: ${element.value}');
  }
}

// Function to log the values of object's variables for debugging.
void debugPrinterObjectProperties(Object obj) {
  final Map<String, dynamic> properties = {};
  for (var key in obj.runtimeType.toString().split(".")) {
    final value = obj.toString();
    properties[key] = value;
  }
  debugLogVariables(properties);
}