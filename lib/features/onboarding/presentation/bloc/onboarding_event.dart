part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {}

class SlidingEvent extends OnboardingEvent {
  final int slideIndex;

  SlidingEvent({required this.slideIndex});
}

class GetStartClickEvent extends OnboardingEvent {}