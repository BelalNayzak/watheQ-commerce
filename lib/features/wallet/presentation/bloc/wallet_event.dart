part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class GetAllWalletsEvent extends WalletEvent {}

class GetWalletDataByIdEvent extends WalletEvent {
  final int id;

  GetWalletDataByIdEvent({required this.id});
}

class DeleteWalletDataByIdEvent extends WalletEvent {
  final int id;

  DeleteWalletDataByIdEvent({required this.id});
}

class AddNewWalletEvent extends WalletEvent {
  final Wallet wallet;

  AddNewWalletEvent({required this.wallet});
}