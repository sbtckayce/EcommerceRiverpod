import 'package:e_commerce/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';
import '../features/cart/controller/cart_controller.dart';
import '../features/wishlist/controller/wishlist_controller.dart';
import '../models/models.dart';

class CartItem extends ConsumerStatefulWidget {
  const CartItem({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  ConsumerState<CartItem> createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<CartItem> {
  int quantity = 1;
  @override
  void initState() {
    quantity = widget.productModel.quantity ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 2, color: Coloors.blackColor),
      ),
      child: Row(children: [
        Image.network(
          widget.productModel.image,
          width: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  widget.productModel.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 16,
                      ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
                            });
                            ref
                                .read(cartControllerProvider)
                                .updateQuantity(widget.productModel, quantity);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Coloors.greenColor,
                              shape: const CircleBorder()),
                          child: const Icon(Icons.remove)),
                      Text(
                        quantity.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                            ref
                                .read(cartControllerProvider)
                                .updateQuantity(widget.productModel, quantity);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Coloors.greenColor,
                              shape: const CircleBorder()),
                          child: const Icon(Icons.add)),
                    ],
                  ),
                  Text(
                    '\$${widget.productModel.price}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.productModel.isFavourite
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_outline),
                    InkWell(
                        onTap: () {
                          ref
                              .read(cartControllerProvider)
                              .removeCartProduct(widget.productModel);
                          showMessage('Remove to cart');
                        },
                        child: Icon(
                          Icons.delete,
                          color: Coloors.greenColor,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
