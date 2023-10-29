import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watheq_ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:watheq_ecommerce/features/cart/presentation/pages/cart_screen.dart';
import 'package:watheq_ecommerce/features/home/presentation/pages/home_screen.dart';
import 'package:watheq_ecommerce/features/settings/presentation/pages/settings_screen.dart';

import '../../../favs/presentation/pages/favs_screen.dart';
import '../bloc/main_nav_bloc.dart';

class MainNav extends StatelessWidget {
  static const id = '/MainNav';

  const MainNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainNavPageView(),
      bottomNavigationBar: MainNavBar(),
    );
  }
}

class MainNavPageView extends StatelessWidget {
  const MainNavPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainNavBloc, MainNavState>(
      listener: (_, state) {},
      builder: (_, state) {
        return PageView(
          controller: mainNavBloc.pageController,
          onPageChanged: (index) {
            mainNavBloc.add(MainNavItemClickEvent(index: index));
          },
          children: const [HomeScreen(), CartScreen(), FavsScreen(), SettingsScreen()],
        );
      },
    );
  }
}

class MainNavBar extends StatelessWidget {
  const MainNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainNavBloc, MainNavState>(
      listener: (_, state) {},
      builder: (_, state) {
        return BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {},
          builder: (context, cartState) {
            return BottomNavigationBar(
              currentIndex: state is MainNavItemClickedState ? state.index : 0,
              onTap: (index) {
                mainNavBloc.add(MainNavItemClickEvent(index: index));
              },
              items: [
                const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(
                  icon: cartBloc.cartItems.isEmpty
                      ? const Icon(Icons.shopping_cart_outlined)
                      : Badge(
                          label: Text('${cartBloc.cartItems.length}'),
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                  label: 'Cart',
                ),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline), label: 'Favorites'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined), label: 'Settings'),
              ],
            );
          },
        );
      },
    );
  }
}