import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:watheq_ecommerce/core/constants/colors.dart';
import 'package:watheq_ecommerce/core/constants/spaces.dart';

import '../../features/onboarding/presentation/widget/single_slide_indicator.dart';

class PrimaryCarousel extends StatefulWidget {
  final List<String> images;
  final double? height;
  const PrimaryCarousel({required this.images, this.height, Key? key}) : super(key: key);

  @override
  State<PrimaryCarousel> createState() => _PrimaryCarouselState();
}

// NOTE: i made it a stateFull widget here as it's just a small separated widget and no need to annoy the code in the bloc with that small separated piece

class _PrimaryCarouselState extends State<PrimaryCarousel> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  width: 100.w,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: colorBlack.withOpacity(0.1),
                        blurRadius: 2.0,
                        // has the effect of softening the shadow
                        spreadRadius: 2.0,
                        // has the effect of extending the shadow
                        offset: const Offset(
                          0.0, // horizontal, move right
                          4.0, // vertical, move down
                        ),
                      ),
                    ],
                  ),
                  child: Image.network(i, fit: BoxFit.fill),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: widget.height ?? 20.h,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (i, _) {
              setState(() {
                _selectedIndex = i;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Spaces.vertical15(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length,
              (index) => SingleSlideIndicator(isActive: _selectedIndex == index)),
        ),
      ],
    );
  }
}