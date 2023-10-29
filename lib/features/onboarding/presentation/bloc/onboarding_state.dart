part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class SlidedState extends OnboardingState {
  final int slideIndex;

  SlidedState({required this.slideIndex});
}

class GetStartButtonClickedState extends OnboardingState {}