import 'package:e_commerce/features/cart/controller/cart_controller.dart';
import 'package:e_commerce/features/order/controller/order_controller.dart';
import 'package:e_commerce/models/models.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pay/pay.dart';

import '../../../constants/constants.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../../../widgets/widgets.dart';
import '../controller/checkout_controller.dart';

class CartCheckoutScreen extends ConsumerStatefulWidget {
  const CartCheckoutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CartCheckoutScreenState();
}

class _CartCheckoutScreenState extends ConsumerState<CartCheckoutScreen> {
  int groupValue = 1;
  final _paymentItems = <PaymentItem>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: Text(
          'Cart Checkout',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Coloors.greenColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Coloors.greenColor)),
              child: Row(
                children: [
                  Radio(
                      activeColor: Coloors.greenColor,
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Cash on Delivery',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Coloors.greenColor)),
              child: Row(
                children: [
                  Radio(
                      activeColor: Coloors.greenColor,
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Pay Online',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InfoTotalCartToCheckout(),
                const SizedBox(
                  height: 10,
                ),
                groupValue == 1
                    ? CustomButton(
                        text: 'Checkout',
                        onPressed: () {
                          ref.read(checkoutControllerProvider).uploadOrderProduct(
                              list: ref.watch(cartControllerProvider).orders,
                              context: context,
                              payment: 'Cash o delivery',
                              mounted: true);
                          ref.read(cartControllerProvider).clearCarts();
                        })
                    : Center(
                      child:  GooglePayButton(
                paymentConfigurationAsset: 'gpay.json',
                paymentItems:  _paymentItems,
                width: 200,
                height: 50,
                
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: (data) {
                  print(data);
                },
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
                    )
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
