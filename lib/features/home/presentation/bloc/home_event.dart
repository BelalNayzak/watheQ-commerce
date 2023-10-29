part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class NotificatinsFabButtonClickEvent extends HomeEvent {}

class CategoryTabClickEvent extends HomeEvent {
  final String tabName;

  CategoryTabClickEvent({required this.tabName});
}

class GetAllProductsEvent extends HomeEvent {}

class ClickCatEvent extends HomeEvent {
  final String cat;

  ClickCatEvent(this.cat);
}