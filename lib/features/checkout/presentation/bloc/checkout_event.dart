part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class GetAllVisasEvent extends CheckoutEvent {}

class AddNewVisaButtonClickEvent extends CheckoutEvent {}

class PayButtonClickEvent extends CheckoutEvent {}