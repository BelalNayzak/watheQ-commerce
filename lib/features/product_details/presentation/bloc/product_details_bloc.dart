import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../main.dart';
import '../../data/model/CartItem.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

ProductDetailsBloc get productDetailsBloc => ProductDetailsBloc.get(navigatorKey.currentContext!);

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  int numOfProducts = 1;

  static ProductDetailsBloc get(context) => BlocProvider.of(context);

  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<ProductDetailsEvent>((event, emit) {
      if (event is IncrementEvent) {
        numOfProducts++;
        emit(IncrementState(num: numOfProducts));
      } else if (event is DecrementEvent) {
        if (numOfProducts > 1) {
          numOfProducts--;
          emit(DecrementState(num: numOfProducts));
        }
      } else if (event is AddToCartButtonClickedEvent) {
        emit(AddToCartState());
      }
    });
  }
}