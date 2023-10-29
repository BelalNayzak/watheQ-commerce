part of 'product_details_bloc.dart';

@immutable
abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class IncrementState extends ProductDetailsState {
  final int num;

  IncrementState({required this.num});
}

class DecrementState extends ProductDetailsState {
  final int num;

  DecrementState({required this.num});
}

class AddToCartState extends ProductDetailsState {}