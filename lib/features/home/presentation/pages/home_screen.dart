import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:watheq_ecommerce/core/constants/spaces.dart';
import 'package:watheq_ecommerce/core/extensions/navigation_extenstions.dart';
import 'package:watheq_ecommerce/core/widgets/app_logo_widget.dart';
import 'package:watheq_ecommerce/core/widgets/primary_divider.dart';
import 'package:watheq_ecommerce/features/notifications/presentation/pages/notifications_screen.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/data.dart';
import '../../../../core/constants/font_sizes.dart';
import '../../../../core/utils/remote_config_utils/remote_config_utils.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_carousel.dart';
import '../../../../core/widgets/primary_padding.dart';
import '../bloc/home_bloc.dart';
import '../widget/product_grid_item_widget.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (_, state) {},
      builder: (_, state) {
        if (state is GetAllProductsLoadingState || state is HomeInitial) {
          return const LoadingWidget();
        } else if (state is GetAllProductsErrorState) {
          return const ErrWidget();
        } else {
          return PrimaryPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppLogoWidget(),
                    FloatingActionButton(
                      heroTag: 'fab_notifications',
                      mini: true,
                      onPressed: () {
                        context.pushNamed(NotificationsScreen.id);
                      },
                      child: const Badge(
                        backgroundColor: colorRed,
                        label: Text('0'), // TODO: make it reactive
                        textColor: colorWhite,
                        child: Icon(Icons.notifications),
                      ),
                    ),
                  ],
                ),
                DefaultTabController(
                  length: cats.length,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spaces.vertical10(),
                        TabBar(
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          indicatorColor: colorTransparent,
                          isScrollable: true,
                          tabs: cats
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    homeBloc.add(ClickCatEvent(e));
                                  },
                                  child: Card(
                                    color:
                                        e == homeBloc.selectedCatName ? colorPrimary : colorWhite,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                                      child: Text(e),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        Spaces.vertical15(),
                        const PrimaryDivider(),
                        Spaces.vertical24(),
                        if (showAds ?? true) ...[
                          Text(
                            'Hot offers %🌟',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: FontSizes.medium,
                            ),
                          ),
                          Spaces.vertical15(),
                          if ((state as GetAllProductsSuccessState).products.isNotEmpty)
                            PrimaryCarousel(
                              images: (state as GetAllProductsSuccessState)
                                  .products
                                  .sublist(0, 3)
                                  .map((e) => e.thumbnail as String)
                                  .toList(),
                            ),
                          Spaces.vertical30(),
                        ],
                        Text(
                          'Explore products🔥',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: FontSizes.medium,
                          ),
                        ),
                        Spaces.vertical15(),
                        Expanded(
                          child: TabBarView(
                            children: cats
                                .map(
                                  (e) => GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                    ),
                                    itemCount:
                                        (state as GetAllProductsSuccessState).products.length,
                                    itemBuilder: (_, i) {
                                      return ProductGridItemWidget(product: state.products[i]);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}