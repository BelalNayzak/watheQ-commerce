import 'package:flutter/material.dart';

import '../../features/cart/presentation/pages/cart_screen.dart';
import '../../features/checkout/presentation/pages/checkout_screen.dart';
import '../../features/favs/presentation/pages/favs_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/main_nav/presentation/pages/main_nav.dart';
import '../../features/notifications/presentation/pages/notifications_screen.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/product_details/presentation/pages/product_details_screen.dart';
import '../../features/settings/presentation/pages/settings_screen.dart';
import '../../features/wallet/presentation/pages/wallet_screen.dart';

class Routing {
  static Map<String, Widget Function(BuildContext)> appRoutes(context) {
    return {
      OnboardingScreen.id: (_) => const OnboardingScreen(),
      MainNav.id: (_) => const MainNav(),
      HomeScreen.id: (_) => const HomeScreen(),
      CartScreen.id: (_) => const CartScreen(),
      FavsScreen.id: (_) => const FavsScreen(),
      SettingsScreen.id: (_) => const SettingsScreen(),
      ProductDetailsScreen.id: (_) => const ProductDetailsScreen(),
      NotificationsScreen.id: (_) => const NotificationsScreen(),
      WalletScreen.id: (_) => const WalletScreen(),
      CheckoutScreen.id: (_) => const CheckoutScreen(),
    };
  }
}