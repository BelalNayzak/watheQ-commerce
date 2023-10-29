import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:watheq_ecommerce/core/constants/font_sizes.dart';
import 'package:watheq_ecommerce/core/extensions/navigation_extenstions.dart';
import 'package:watheq_ecommerce/features/product_details/presentation/pages/product_details_screen.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/constants/spaces.dart';
import '../../data/model/all_products_response_model.dart';
import '../../data/model/product_model.dart';

class ProductGridItemWidget extends StatelessWidget {
  final Product product;

  const ProductGridItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.h),
      decoration: BoxDecoration(
        color: colorWhite.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: colorGrey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.pushNamed(ProductDetailsScreen.id, arguments: product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(product.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorBlack.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    if (product.discountPercentage != null)
                      Positioned(
                        bottom: 1.2.h,
                        left: 1.2.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.5.h,
                            horizontal: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: colorWhite.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: colorGrey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
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
                      ),
                    Positioned(
                      top: 1.2.h,
                      right: 1.2.h,
                      child: InkWell(
                        onTap: () {
                          // product.toggleMealFavStatus();
                          // if (product.isFav) {
                          //   MealsCacher.cacheFavProduct(context, product);
                          // } else {
                          //   MealsCacher.unCacheFavProduct(context, product);
                          // }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.5.h,
                            horizontal: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: colorWhite.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: colorGrey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            color: colorPrimary,
                            size: 2.5.h,
                          ),
                          // child: product.isFav
                          //     ? Icon(
                          //         Icons.favorite,
                          //         color: colorPrimary,
                          //         size: 2.5.h,
                          //       )
                          //     : Icon(
                          //         Icons.favorite_border,
                          //         color: colorPrimary,
                          //         size: 2.5.h,
                          //       ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1.2.h,
                      left: 1.2.h,
                      child: Wrap(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.5.h,
                              horizontal: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: colorWhite.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: colorGrey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              '${product.brand ?? '-'}',
                              style: TextStyle(
                                fontSize: FontSizes.x_small,
                                fontWeight: FontWeight.bold,
                                color: colorBlack54,
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
                              color: colorWhite.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: colorGrey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              '${product.category ?? '-'}',
                              style: TextStyle(
                                fontSize: FontSizes.x_small,
                                fontWeight: FontWeight.bold,
                                color: colorBlack54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.5.h, right: 1.5.h, top: 2.5.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${product.title ?? '-'}',
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: FontSizes.medium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spaces.horizontal15(),
                  InkWell(
                    onTap: () {
                      context.pushNamed(ProductDetailsScreen.id, arguments: product);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 1.h,
                        horizontal: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: colorPrimary.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: colorGrey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.add,
                        color: colorWhite,
                        size: 2.5.h,
                      ),
                      // child: product.isFav
                      //     ? Icon(
                      //         Icons.favorite,
                      //         color: colorPrimary,
                      //         size: 2.5.h,
                      //       )
                      //     : Icon(
                      //         Icons.favorite_border,
                      //         color: colorPrimary,
                      //         size: 2.5.h,
                      //       ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.5.h, right: 1.5.h, bottom: 1.5.h, top: 1.h),
              child: Text(
                '${product.description ?? '-'}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: FontSizes.xx_small,
                  color: colorGrey,
                  height: 1.2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.5.h, right: 1.5.h, top: 0.5.h, bottom: 2.h),
              child: Wrap(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}