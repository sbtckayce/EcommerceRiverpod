


import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/cart/controller/cart_controller.dart';
import 'package:e_commerce/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/widgets.dart';
import '../controller/wishlist_controller.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {



  @override
  Widget build(BuildContext context) {
    final wishlists = ref.watch(wishlistControllerProvider).wishlists;
    return Scaffold(
      appBar: AppBar(
        leading:const BackButton(),
         centerTitle: true,
        title: Text(
          'My Wishlist',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Coloors.greenColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: wishlists.isEmpty ?const Center(child: Text('Empty Wishlist'),) : Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView.builder(
          itemCount: wishlists.length,
          physics:const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return WishlistItem(productModel: wishlists[index],);
          },
        ),
      ),
    );
  }
}
