import 'package:e_commerce/features/wishlist/controller/wishlist_controller.dart';
import 'package:e_commerce/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';
import '../features/cart/controller/cart_controller.dart';
import '../models/models.dart';

class WishlistItem extends ConsumerStatefulWidget {
  const WishlistItem({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  ConsumerState<WishlistItem> createState() => _WishlistItemState();
}

class _WishlistItemState extends ConsumerState<WishlistItem> {
  
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
             const SizedBox(height: 30,),
              Padding(
                               padding: const EdgeInsets.only(left: 15),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   
                        InkWell(
                          onTap: (){
                            ref.read(wishlistControllerProvider).removeWishlistProduct(widget.productModel);
                            showMessage('Remove to Wishlist');
                          },
                          child: Text(
                            'Remove to Wishlist',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Coloors.greenColor),
                          ),
                        ),
                        
                    
                    Text(
                      '\$${widget.productModel.price}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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
