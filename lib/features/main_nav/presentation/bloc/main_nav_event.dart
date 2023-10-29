part of 'main_nav_bloc.dart';

@immutable
abstract class MainNavEvent {}

class MainNavItemClickEvent extends MainNavEvent {
  final int index;

  MainNavItemClickEvent({required this.index});
}