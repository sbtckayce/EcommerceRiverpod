
import 'package:e_commerce/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistRepositoryProvider = ChangeNotifierProvider<WishlistRepository>((ref) => WishlistRepository());

class WishlistRepository extends ChangeNotifier{

  final List<ProductModel> _wishlists = [];

  void addWishlistProduct(ProductModel productModel){
    _wishlists.add(productModel);
    notifyListeners();
  }
  void removeWishlistProduct(ProductModel productModel){
    _wishlists.remove(productModel);
     notifyListeners();
  }
  List<ProductModel> get wishlists => _wishlists;
}
