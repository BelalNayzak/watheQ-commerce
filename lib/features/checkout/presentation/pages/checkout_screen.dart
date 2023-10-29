import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watheq_ecommerce/core/widgets/empty_state_widget.dart';
import 'package:watheq_ecommerce/core/widgets/primary_padding.dart';

import '../../../../core/widgets/error_widget.dart';
import '../bloc/checkout_bloc.dart';
import 'package:watheq_ecommerce/core/widgets/primary_underline.dart';
import 'package:watheq_ecommerce/features/cart/presentation/widget/cart_item_widget.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/font_sizes.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/widgets/primary_button.dart';

class CheckoutScreen extends StatefulWidget {
  static const id = '/CheckoutScreen';

  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    checkoutBloc.add(GetAllVisasEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CheckoutPage(),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    double total = args['total'];
    double subtotal = args['subtotal'];

    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetAllVisasState) {
          if (state.visas.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Text('No payment method available!'),
                  Spaces.vertical24(),
                  PrimaryButton(
                    text: 'Add payment method',
                    onPressed: () => checkoutBloc.add(AddNewVisaButtonClickEvent()),
                  ),
                ],
              ),
            );
          } else {
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
                        'Your payment methods',
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
                        itemCount: state.visas.length,
                        separatorBuilder: (_, i) => Spaces.horizontal15(),
                        itemBuilder: (_, i) {
                          return ListTile(
                            leading: const Icon(Icons.credit_card_rounded),
                            title: Text(
                                '${state.visas[i].cardNumber.substring(0, 4)}*******${state.visas[i].cardNumber.substring(8)}'),
                            subtitle: Text('card id: ${state.visas[i].id}'),
                          );
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
                            subtotal.toStringAsFixed(1),
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
                            'Total',
                            style: TextStyle(
                              fontSize: FontSizes.small,
                              fontWeight: FontWeight.bold,
                              color: colorBlack,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            total.toStringAsFixed(1),
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
                        text: 'Pay',
                        textColor: colorWhite,
                        onPressed: () {
                          checkoutBloc.add(PayButtonClickEvent());
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        }
        return const ErrWidget();
      },
    );
  }
}