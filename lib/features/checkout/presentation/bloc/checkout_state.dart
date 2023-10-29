part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class GetAllVisasState extends CheckoutState {
  final List<Visa> visas;

  GetAllVisasState({required this.visas});
}

class AddNewVisaButtonClickState extends CheckoutState {}

class PayButtonClickState extends CheckoutState {}

class SelectVisaState extends CheckoutState {}