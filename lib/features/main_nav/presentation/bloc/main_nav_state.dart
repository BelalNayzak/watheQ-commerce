part of 'main_nav_bloc.dart';

@immutable
abstract class MainNavState {}

class MainNavInitial extends MainNavState {
  final int index;

  MainNavInitial({required this.index});
}

class MainNavItemClickedState extends MainNavState {
  final int index;

  MainNavItemClickedState({required this.index});
}