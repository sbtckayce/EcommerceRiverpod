import 'package:e_commerce/features/cart/controller/cart_controller.dart';
import 'package:e_commerce/features/cart/screen/cart_screen.dart';
import 'package:e_commerce/features/wishlist/controller/wishlist_controller.dart';
import 'package:e_commerce/features/wishlist/screen/wishlist_screen.dart';
import 'package:e_commerce/models/models.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../checkout/screens/checkout_screen.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          IconButton(
              onPressed: () {
                AppRoute.push(widget: CartScreen(), context: context);
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body:
         SingleChildScrollView(
           child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(
                    child: Image.network(
                  widget.productModel.image,
                  width: 250,
                  height: 250,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.productModel.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget.productModel.isFavourite =
                                !widget.productModel.isFavourite;
                          });
                          if (widget.productModel.isFavourite) {
                            ref
                                .read(wishlistControllerProvider)
                                .addWishlistProduct(widget.productModel);
                            showMessage('Add To Wishlist');
                          } else {
                            ref
                                .read(wishlistControllerProvider)
                                .removeWishlistProduct(widget.productModel);
                            showMessage('Remove To Wishlist');
                          }
                        },
                        icon: ref
                                .watch(wishlistControllerProvider)
                                .wishlists
                                .contains(widget.productModel)
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_outline))
                  ],
                ),
                Text(widget.productModel.description),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                        
                            style: ElevatedButton.styleFrom(
                              
                                shape: RoundedRectangleBorder(
                                  
                                  borderRadius: BorderRadius.circular(5)
                                ),
                               
                                backgroundColor: Coloors.greenColor),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                                
                              });
                            },
                            child: const Icon(Icons.remove)),
                            const SizedBox(width: 10,),
                        Text(
                          quantity.toString(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),  const SizedBox(width: 10,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                               
                                shape: RoundedRectangleBorder(
                                  
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                backgroundColor: Coloors.greenColor),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: const Icon(Icons.add)),
                      ],
                    ),
                  
                    Text('\$${widget.productModel.price}',style: Theme.of(context).textTheme.titleMedium,)
                  ],
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          ProductModel product =
                              widget.productModel.copyWith(quantity: quantity);
                  
                          ref.read(cartControllerProvider).addCartProduct(product);
                          showMessage('Add to cart');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Coloors.whiteColor,
                            elevation: 0,
                            minimumSize: const Size(120, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side:
                                    BorderSide(width: 1, color: Coloors.greenColor))),
                        child: Text(
                          'ADD TO CART',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Coloors.greenColor),
                        )),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                            ProductModel product =
                              widget.productModel.copyWith(quantity: quantity);
                          AppRoute.push(widget: CheckoutScreen(productModel: product,), context: context);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120, 40),
                            backgroundColor: Coloors.greenColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side:
                                    BorderSide(width: 1, color: Coloors.greenColor))),
                        child: Text(
                          'BUY',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Coloors.whiteColor),
                        ))
                  ],
                ),
                 const SizedBox(height: 50,),
              ]),
            ),
         ),
        
      
    );
  }
}
