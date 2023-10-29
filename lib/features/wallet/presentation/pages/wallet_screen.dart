import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watheq_ecommerce/core/widgets/primary_padding.dart';

import '../bloc/wallet_bloc.dart';

class WalletScreen extends StatelessWidget {
  static const id = '/WalletScreen';

  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WalletPage(),
    );
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {},
      builder: (context, state) {
        return PrimaryPadding(
          child: Text('hi ii'),
        );
      },
    );
  }
}