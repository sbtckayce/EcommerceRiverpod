import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/cart/controller/cart_controller.dart';
import 'package:e_commerce/features/cart/repository/cart_repository.dart';
import 'package:e_commerce/features/checkout/screens/cart_checkout_screen.dart';
import 'package:e_commerce/features/checkout/screens/checkout_screen.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/widgets.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final carts = ref.watch(cartControllerProvider).carts;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Cart',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Coloors.greenColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: carts.isEmpty
          ? const Center(
              child: Text('Empty Cart'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ref.watch(cartControllerProvider).freeDeliveryFeeString,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: carts.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CartItem(
                          productModel: carts[index],
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const InfoTotalCartToCheckout(),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: 'Checkout',
                          onPressed: () {
                            ref.read(cartRepositoryProvider).clearsOrder();
                            ref
                                .read(cartControllerProvider)
                                .addOrderProductCart();

                            final orders =
                                ref.watch(cartControllerProvider).orders;
                            if (orders.isEmpty) {
                              showMessage('Cart is empty');
                            } else {
                              print(orders);
                              AppRoute.push(
                                  widget: CartCheckoutScreen(),
                                  context: context);
                            }
                          })
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
