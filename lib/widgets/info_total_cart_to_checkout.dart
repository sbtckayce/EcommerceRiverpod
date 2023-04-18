import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/cart/controller/cart_controller.dart';

class InfoTotalCartToCheckout extends ConsumerWidget {
  const InfoTotalCartToCheckout({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SubTotal',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              ref.watch(cartControllerProvider).subTotalString,
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
              ref.watch(cartControllerProvider).deliveryFeeString,
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
              ref.watch(cartControllerProvider).totalString,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ],
    );
  }
}
