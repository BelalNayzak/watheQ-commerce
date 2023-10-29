import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:watheq_ecommerce/core/constants/spaces.dart';
import 'package:watheq_ecommerce/core/extensions/navigation_extenstions.dart';
import 'package:watheq_ecommerce/core/utils/ux_utils/notify_actions_helper/notify_actions_helper.dart';
import 'package:watheq_ecommerce/core/widgets/primary_button.dart';
import 'package:watheq_ecommerce/core/widgets/primary_carousel.dart';
import 'package:watheq_ecommerce/core/widgets/primary_padding.dart';
import 'package:watheq_ecommerce/features/home/data/model/product_model.dart';
import 'package:watheq_ecommerce/features/product_details/data/model/CartItem.dart';
import 'package:watheq_ecommerce/features/product_details/presentation/bloc/product_details_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/font_sizes.dart';
import '../../../../core/widgets/primary_underline.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const id = '/ProductDetailsScreen';

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments! as Product;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          productDetailsBloc.numOfProducts = 1;
          return true;
        },
        child: ProductDetailsPage(product: product),
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments! as Product;

    return BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
      listener: (context, state) {
        if (state is ProductDetailsInitial) {
          productDetailsBloc.numOfProducts = 1;
        } else if (state is AddToCartState) {
          // TODO: add to cart first
          cartBloc.add(
            AddToCartEvent(
              cartItem: CartItem(
                quantity: productDetailsBloc.numOfProducts,
                product: product,
              ),
            ),
          );
          productDetailsBloc.numOfProducts = 1;
          context.pop();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: PrimaryPadding(
                child: ListView(
                  children: [
                    PrimaryCarousel(images: product.images!, height: 30.h),
                    Spaces.vertical30(),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.5.h,
                            horizontal: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: colorGrey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${product.category ?? '-'}',
                            style: TextStyle(
                              fontSize: FontSizes.xx_small,
                              fontWeight: FontWeight.bold,
                              color: colorGrey,
                            ),
                          ),
                        ),
                        Spaces.horizontal5(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.5.h,
                            horizontal: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: colorGrey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${product.brand ?? '-'}',
                            style: TextStyle(
                              fontSize: FontSizes.xx_small,
                              fontWeight: FontWeight.bold,
                              color: colorGrey,
                            ),
                          ),
                        ),
                        Spaces.horizontal5(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.5.h,
                            horizontal: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: colorGrey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'In stock: ${product.stock ?? '-'}',
                            style: TextStyle(
                              fontSize: FontSizes.xx_small,
                              fontWeight: FontWeight.bold,
                              color: colorGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spaces.vertical30(),
                    Text(
                      '${product.title ?? '-'}',
                      // maxLines: 2,
                      // overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: FontSizes.xxx_large,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spaces.vertical10(),
                    Wrap(
                      // mainAxisAlignment: MainAxisAlignment.center,
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
                                  fontSize: FontSizes.x_small,
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
                                    fontSize: FontSizes.x_small,
                                    fontWeight: FontWeight.bold,
                                    color: colorBlack54,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                Icons.star_rate,
                                color: colorYellow,
                                size: 2.h,
                              ),
                              SizedBox(width: 0.5.h),
                              Text(
                                '${product.rating ?? '-'}',
                                style: TextStyle(
                                  fontSize: FontSizes.x_small,
                                  fontWeight: FontWeight.bold,
                                  color: colorBlack54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (product.discountPercentage != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.5.h,
                              horizontal: 1.h,
                            ),
                            margin: EdgeInsets.only(top: 1.h),
                            decoration: BoxDecoration(
                              color: colorAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.discount_outlined,
                                  color: colorPrimary,
                                  size: 2.h,
                                ),
                                SizedBox(width: 0.5.h),
                                Text(
                                  'you will save ${product.discountPercentage!.toDouble().round()}% on this item.',
                                  style: TextStyle(
                                    fontSize: FontSizes.x_small,
                                    fontWeight: FontWeight.bold,
                                    color: colorBlack54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Spaces.vertical25(),
                    Text(
                      'Description:',
                      // maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: FontSizes.small,
                        color: colorBlack,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    Spaces.vertical10(),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryUnderline(
                          width: 20,
                          height: 2,
                          color: colorPrimary,
                        ),
                      ],
                    ),
                    Spaces.vertical10(),
                    Text(
                      '${product.description ?? '-'}',
                      // maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: FontSizes.small,
                        color: colorBlack,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              decoration: BoxDecoration(
                color: colorAccent.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: 'product_details_dec_fab',
                    elevation: 0,
                    onPressed: () {
                      if (productDetailsBloc.numOfProducts > 1) {
                        productDetailsBloc.add(DecrementEvent());
                      } else {
                        showTopErrorMessage(message: 'You must order 1 item as minimum.');
                      }
                    },
                    mini: true,
                    backgroundColor: colorAccent.withOpacity(0.2),
                    child: const Icon(Icons.remove, color: colorPrimary),
                  ),
                  Spaces.horizontal15(),
                  Text(
                    '${productDetailsBloc.numOfProducts}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizes.large,
                    ),
                  ),
                  Spaces.horizontal15(),
                  FloatingActionButton(
                    heroTag: 'product_details_inc_fab',
                    elevation: 0,
                    onPressed: () {
                      if (productDetailsBloc.numOfProducts < product.stock) {
                        productDetailsBloc.add(IncrementEvent());
                      } else {
                        showTopErrorMessage(message: 'There is only ${product.stock} in stock.');
                      }
                    },
                    mini: true,
                    backgroundColor: colorAccent.withOpacity(0.2),
                    child: const Icon(Icons.add, color: colorPrimary),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    width: 40.w,
                    text: 'Add to cart',
                    textColor: colorWhite,
                    onPressed: () {
                      productDetailsBloc.add(AddToCartButtonClickedEvent());
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}