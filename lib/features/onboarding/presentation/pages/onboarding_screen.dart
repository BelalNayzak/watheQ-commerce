import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watheq_ecommerce/core/constants/colors.dart';
import 'package:watheq_ecommerce/core/constants/spaces.dart';
import 'package:watheq_ecommerce/core/extensions/navigation_extenstions.dart';
import 'package:watheq_ecommerce/core/widgets/primary_button.dart';
import 'package:watheq_ecommerce/core/widgets/primary_padding.dart';
import 'package:watheq_ecommerce/features/home/presentation/pages/home_screen.dart';
import 'package:watheq_ecommerce/features/main_nav/presentation/pages/main_nav.dart';
import 'package:watheq_ecommerce/features/onboarding/presentation/bloc/onboarding_bloc.dart';

import '../../../../core/constants/data.dart';
import '../widget/onboarding_slide.dart';
import '../widget/single_slide_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  static const id = '/OnboardingScreen';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (_, state) {
        if (state is GetStartButtonClickedState) {
          context.pushNamed(MainNav.id);
        }
      },
      builder: (_, state) {
        return PrimaryPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spaces.vertical16(),
              Expanded(
                child: PageView(
                  controller: onboardingBloc.pageController,
                  onPageChanged: (int index) {
                    onboardingBloc.add(SlidingEvent(slideIndex: index));
                  },
                  children: onboardingSlidesData
                      .map((e) => OnboardingSlide(
                            title: e['title'],
                            subtitle: e['subtitle'],
                            image: e['image'],
                          ))
                      .toList(),
                ),
              ),
              Spaces.vertical16(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleSlideIndicator(
                      isActive: state is OnboardingInitial ||
                          (state is SlidedState && state.slideIndex == 0)),
                  SingleSlideIndicator(isActive: state is SlidedState && state.slideIndex == 1),
                  SingleSlideIndicator(isActive: state is SlidedState && state.slideIndex == 2),
                ],
              ),
              Spaces.vertical16(),
              PrimaryButton(
                text: 'get started',
                textColor: colorWhite,
                onPressed: () => onboardingBloc.add(GetStartClickEvent()),
              ),
              Spaces.vertical16(),
            ],
          ),
        );
      },
    );
  }
}