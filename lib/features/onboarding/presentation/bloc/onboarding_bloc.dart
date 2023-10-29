import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../main.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

OnboardingBloc get onboardingBloc => OnboardingBloc.get(navigatorKey.currentContext!);

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final PageController pageController = PageController(initialPage: 0);

  static OnboardingBloc get(context) => BlocProvider.of(context);

  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>(
      (event, emit) {
        if (event is SlidingEvent) {
          emit(SlidedState(slideIndex: event.slideIndex));
        } else if (event is GetStartClickEvent) {
          emit(GetStartButtonClickedState());
        }
      },
    );
  }
}