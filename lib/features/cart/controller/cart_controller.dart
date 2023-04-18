import 'package:e_commerce/features/cart/repository/cart_repository.dart';
import 'package:e_commerce/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartControllerProvider = Provider(
    (ref) => CartController(cartRepository: ref.watch(cartRepositoryProvider)));

class CartController {
  final CartRepository _cartRepository;
  CartController({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  List<ProductModel> get carts => _cartRepository.carts;
  List<ProductModel> get orders => _cartRepository.orders;

  addCartProduct(ProductModel productModel) {
    _cartRepository.addCartProduct(productModel);
  }

  removeCartProduct(ProductModel productModel) {
    _cartRepository.removeCartProduct(productModel);
  }

  updateQuantity(ProductModel productModel, int quantity) {
    return _cartRepository.updateQuantity(productModel, quantity);
  }

  addOrderProduct(ProductModel productModel){
   return _cartRepository.addOrderProduct(productModel);
  }
  addOrderProductCart(){
    return _cartRepository.addOrderProductCart();
  }
  clearCarts(){
    return _cartRepository.clearsCart();
  }
  clearOrders(){
    return _cartRepository.clearsOrder();
  }

  String get totalString => _cartRepository.totalString;

  String get deliveryFeeString => _cartRepository.deliveryFeeString;

  String get subTotalString => _cartRepository.subtotalString;

  String get freeDeliveryFeeString => _cartRepository.freedeliveryFreeString;


  
}
