import 'package:e_commerce/features/cart/controller/cart_controller.dart';
import 'package:e_commerce/features/order/controller/order_controller.dart';
import 'package:e_commerce/models/models.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';

import '../../../widgets/widgets.dart';
import '../controller/checkout_controller.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
         centerTitle: true,
        title: Text(
          'Checkout',
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
                          groupValue=value!;
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
                          groupValue=value!;
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
              children: [
                  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SubTotal',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
               '\$${widget.productModel.price}',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery Fee',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              widget.productModel.price >500 ? '0': '150',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const Divider(
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
             widget.productModel.price > 500 ?  '\$${widget.productModel.price}' :'\$${widget.productModel.price  + 150.0}',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    text: 'Checkout',
                    onPressed: () {
                      ref.read(cartControllerProvider).clearOrders();
                      ref
                          .read(cartControllerProvider)
                          .addOrderProduct(widget.productModel);
                      ref.read(checkoutControllerProvider).uploadOrderProduct(
                          list: ref.watch(cartControllerProvider).orders,
                          context: context,
                          payment:
                              groupValue == 1 ? 'Cash o delivery' : 'Pay online',
                          mounted: true);
                    
                    }),
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
