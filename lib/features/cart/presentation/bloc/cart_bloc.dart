import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:watheq_ecommerce/core/utils/debugging_utils/debugging_helper.dart';

import '../../../../main.dart';
import '../../../product_details/data/model/CartItem.dart';

part 'cart_event.dart';
part 'cart_state.dart';

CartBloc get cartBloc => CartBloc.get(navigatorKey.currentContext!);

class CartBloc extends Bloc<CartEvent, CartState> {
  static CartBloc get(context) => BlocProvider.of(context);

  final List<CartItem> cartItems = [];

  double get total => _calcTotal();

  double get subtotal => _calcSubTotal();

  double get taxFees => 14; // could be come from db

  double get deliveryFees => 20; // could be come from db based on distance on so on

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      if (event is LoadCartItemsEvent) {
        // I'm checking below
      } else if (event is AddToCartEvent) {
        cartItems.add(event.cartItem);
      } else if (event is RemoveFromCartEvent) {
        cartItems.remove(event.cartItem);
        cartItems.removeWhere((item) => item.product.id == event.cartItem);
      } else if (event is walletButtonClickedEvent) {
        emit(walletButtonClickedState());
      }

      if (cartItems.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(CartLoadedState(cartItems: cartItems));
      }
    });
  }

  double _calcTotal() {
    double total = 0;

    total = subtotal + deliveryFees + (subtotal * (taxFees / 100));

    return total;
  }

  double _calcSubTotal() {
    double subtotal = 0;
    for (var item in cartItems) {
      subtotal +=
          item.quantity * (item.product.price * ((100 - item.product.discountPercentage) / 100));
    }
    return subtotal;
  }
}