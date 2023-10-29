import 'package:flutter/material.dart';

class FavsScreen extends StatelessWidget {
  static const id = '/FavsScreen';

  const FavsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavsPage(),
    );
  }
}

class FavsPage extends StatelessWidget {
  const FavsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('favs'),
    );
  }
}