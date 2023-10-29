part of 'wallet_bloc.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class GetAllWalletsSuccessState extends WalletState {
  final List<Wallet> wallets;

  GetAllWalletsSuccessState({required this.wallets});
}

class GetAllWalletsErrorState extends WalletState {
  final String msg;

  GetAllWalletsErrorState({required this.msg});
}

class GetWalletDataByIdSuccessState extends WalletState {
  final Wallet wallet;

  GetWalletDataByIdSuccessState({required this.wallet});
}

class GetWalletDataByIdErrorState extends WalletState {
  final String msg;

  GetWalletDataByIdErrorState({required this.msg});
}

class DeleteWalletDataByIdSuccessState extends WalletState {}

class DeleteWalletDataByIdErrorState extends WalletState {
  final String msg;

  DeleteWalletDataByIdErrorState({required this.msg});
}

class AddNewWalletSuccessState extends WalletState {}

class AddNewWalletErrorState extends WalletState {
  final String msg;

  AddNewWalletErrorState({required this.msg});
}