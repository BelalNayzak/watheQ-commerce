part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class NotificatinsFabButtonClickedState extends HomeState {}

class CategoryTabClickedState extends HomeState {
  final String tabName;

  CategoryTabClickedState({required this.tabName});
}

class GetAllProductsLoadingState extends HomeState {}

class GetAllProductsErrorState extends HomeState {
  final String msg;

  GetAllProductsErrorState({required this.msg});
}

class GetAllProductsSuccessState extends HomeState {
  final List<Product> products;

  GetAllProductsSuccessState({required this.products});
}

class ClickCatState extends HomeState {
  final List<Product> products;

  ClickCatState({required this.products});
}