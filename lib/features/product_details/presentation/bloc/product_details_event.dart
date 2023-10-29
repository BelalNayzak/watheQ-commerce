part of 'product_details_bloc.dart';

@immutable
abstract class ProductDetailsEvent {}

class IncrementEvent extends ProductDetailsEvent {}

class DecrementEvent extends ProductDetailsEvent {}

class AddToCartButtonClickedEvent extends ProductDetailsEvent {}