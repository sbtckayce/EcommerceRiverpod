import 'package:e_commerce/features/cart/repository/cart_repository.dart';
import 'package:e_commerce/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/wishlist_repository.dart';

final wishlistControllerProvider = Provider(
    (ref) => WishlistController(wishlistRepository: ref.watch(wishlistRepositoryProvider)));

class WishlistController {
  final WishlistRepository _wishlistRepository;
  WishlistController({required WishlistRepository wishlistRepository})
      : _wishlistRepository = wishlistRepository;

  List<ProductModel> get wishlists => _wishlistRepository.wishlists;

  addWishlistProduct(ProductModel productModel) {
    _wishlistRepository.addWishlistProduct(productModel);
  }

  removeWishlistProduct(ProductModel productModel) {
    _wishlistRepository.removeWishlistProduct(productModel);
  }
}
