import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

part 'main_nav_event.dart';
part 'main_nav_state.dart';

MainNavBloc get mainNavBloc => MainNavBloc.get(navigatorKey.currentContext!);

class MainNavBloc extends Bloc<MainNavEvent, MainNavState> {
  final PageController pageController = PageController(initialPage: 0);

  static MainNavBloc get(context) => BlocProvider.of(context);

  MainNavBloc() : super(MainNavInitial(index: 0)) {
    on<MainNavEvent>((event, emit) {
      if (event is MainNavItemClickEvent) {
        emit(MainNavItemClickedState(index: event.index));
        pageController.jumpToPage(event.index);
      }
    });
  }
}