part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class LoadCartItemsEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartItem cartItem;

  AddToCartEvent({required this.cartItem});
}

class RemoveFromCartEvent extends CartEvent {
  final CartItem cartItem;

  RemoveFromCartEvent({required this.cartItem});
}

class CartDecrementEvent extends CartEvent {
  final int quantity;

  CartDecrementEvent({required this.quantity});
}

class CartIncrementEvent extends CartEvent {
  final int quantity;

  CartIncrementEvent({required this.quantity});
}

class walletButtonClickedEvent extends CartEvent {}