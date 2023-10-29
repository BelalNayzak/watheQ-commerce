import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:watheq_ecommerce/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/font_sizes.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/utils/ux_utils/notify_actions_helper/notify_actions_helper.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/data/model/product_model.dart';
import '../../../product_details/data/model/CartItem.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({required this.cartItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = cartItem.product;

    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      product.thumbnail,
                    ),
                  ),
                ),
                child: CircleAvatar(
                    child: Text(
                  'x${cartItem.quantity}',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                )),
              ),
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${product.title}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizes.large,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: colorRed,
                              size: 20,
                            ),
                            onPressed: () {
                              cartBloc.add(RemoveFromCartEvent(cartItem: cartItem));
                            },
                          ),
                        ],
                      ),
                      subtitle: Wrap(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.h),
                            margin: EdgeInsets.only(right: 1.h, bottom: 0.5.h),
                            decoration: BoxDecoration(
                              color: colorAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: colorPrimary,
                                  size: 2.h,
                                ),
                                SizedBox(width: 0.5.h),
                                Text(
                                  '${product.price ?? '-'} EGP',
                                  style: TextStyle(
                                    fontSize: FontSizes.xxx_small,
                                    fontWeight: FontWeight.bold,
                                    color: colorBlack54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (product.discountPercentage != null)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.h),
                              margin: EdgeInsets.only(right: 1.h, bottom: 0.5.h),
                              decoration: BoxDecoration(
                                color: colorAccent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    color: colorGrey,
                                    size: 2.h,
                                  ),
                                  SizedBox(width: 0.5.h),
                                  Text(
                                    '${(product.price!.toDouble() * (100 - product.discountPercentage!.toDouble()) / 100).round()} EGP',
                                    style: TextStyle(
                                      decorationStyle: TextDecorationStyle.solid,
                                      decorationThickness: 1,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: FontSizes.xxx_small,
                                      fontWeight: FontWeight.bold,
                                      color: colorBlack54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Spaces.horizontal15(),
                    //     InkWell(
                    //       onTap: () {
                    //         if (cartItem.quantity > 1) {
                    //           cartBloc.add(CartDecrementEvent(quantity: cartItem.quantity));
                    //         } else {
                    //           showTopErrorMessage(message: 'You must order 1 item as minimum.');
                    //         }
                    //       },
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //           vertical: 0.5.h,
                    //           horizontal: 0.5.h,
                    //         ),
                    //         decoration: BoxDecoration(
                    //           color: colorAccent.withOpacity(0.5),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: const Icon(Icons.remove, color: colorPrimary),
                    //       ),
                    //     ),
                    //     Spaces.horizontal15(),
                    //     Text(
                    //       '${cartItem.quantity}',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: FontSizes.large,
                    //       ),
                    //     ),
                    //     Spaces.horizontal15(),
                    //     InkWell(
                    //       onTap: () {
                    //         if (cartItem.quantity < product.stock) {
                    //           cartBloc.add(CartIncrementEvent(quantity: cartItem.quantity));
                    //         } else {
                    //           showTopErrorMessage(
                    //               message: 'There is only ${product.stock} in stock.');
                    //         }
                    //       },
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //           vertical: 0.5.h,
                    //           horizontal: 0.5.h,
                    //         ),
                    //         decoration: BoxDecoration(
                    //           color: colorAccent.withOpacity(0.5),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: const Icon(Icons.add, color: colorPrimary),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}