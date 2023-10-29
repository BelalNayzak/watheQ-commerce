part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItem> cartItems;

  CartLoadedState({required this.cartItems});
}

class CartEmptyState extends CartState {}

class CartIncrementState extends CartState {
  final int quantity;

  CartIncrementState({required this.quantity});
}

class CartDecrementState extends CartState {
  final int quantity;

  CartDecrementState({required this.quantity});
}

class walletButtonClickedState extends CartState {}