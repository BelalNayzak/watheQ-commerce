import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watheq_ecommerce/core/extensions/navigation_extenstions.dart';
import 'package:watheq_ecommerce/core/widgets/empty_state_widget.dart';
import 'package:watheq_ecommerce/core/widgets/primary_underline.dart';
import 'package:watheq_ecommerce/features/cart/presentation/widget/cart_item_widget.dart';
import 'package:watheq_ecommerce/features/checkout/presentation/pages/checkout_screen.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/font_sizes.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/primary_carousel.dart';
import '../../../../core/widgets/primary_padding.dart';
import '../../../wallet/presentation/pages/wallet_screen.dart';
import '../bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  static const id = '/CartScreen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    cartBloc.add(LoadCartItemsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is walletButtonClickedState) {
          context.pushNamed(CheckoutScreen.id, arguments: {
            'total': cartBloc.total,
            'subtotal': cartBloc.total,
          });
        }
      },
      builder: (context, state) {
        if (state is CartEmptyState) {
          return const EmptyStateWidget();
        } else if (state is CartLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryPadding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spaces.vertical10(),
                    Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: FontSizes.medium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spaces.vertical3(),
                    const PrimaryUnderline(color: colorPrimary, height: 2),
                  ],
                ),
              ),

              ///* order details

              Expanded(
                child: PrimaryPadding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 5,
                    child: ListView.separated(
                      itemCount: state.cartItems.length,
                      separatorBuilder: (_, i) => Spaces.horizontal15(),
                      itemBuilder: (_, i) {
                        return CartItemWidget(cartItem: state.cartItems[i]);
                      },
                    ),
                  ),
                ),
              ),

              ///* payment details

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                decoration: BoxDecoration(
                  color: colorAccent.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spaces.vertical5(),
                    Text(
                      'Payment Details',
                      style: TextStyle(
                        fontSize: FontSizes.medium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spaces.vertical3(),
                    const PrimaryUnderline(color: colorPrimary, height: 2),
                    Spaces.vertical20(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: FontSizes.small,
                            color: colorBlack,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          cartBloc.subtotal.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: FontSizes.small,
                            color: colorBlack,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    Spaces.vertical10(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax',
                          style: TextStyle(
                            fontSize: FontSizes.xx_small,
                            color: colorBlack,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          '${cartBloc.taxFees}',
                          style: TextStyle(
                            fontSize: FontSizes.xx_small,
                            color: colorBlack,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    Spaces.vertical10(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery fees',
                          style: TextStyle(
                            fontSize: FontSizes.xx_small,
                            color: colorBlack,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          '${cartBloc.deliveryFees}',
                          style: TextStyle(
                            fontSize: FontSizes.xx_small,
                            color: colorBlack,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    Spaces.vertical10(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: FontSizes.small,
                            fontWeight: FontWeight.bold,
                            color: colorBlack,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          cartBloc.total.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: FontSizes.small,
                            fontWeight: FontWeight.bold,
                            color: colorBlack,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    Spaces.vertical20(),
                    PrimaryButton(
                      text: 'Checkout',
                      textColor: colorWhite,
                      onPressed: () {
                        cartBloc.add(walletButtonClickedEvent());
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return const EmptyStateWidget();
        }
      },
    );
  }
}