import 'package:e_commerce/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRepositoryProvider =
    ChangeNotifierProvider<CartRepository>((ref) => CartRepository());

class CartRepository extends ChangeNotifier {
  final List<ProductModel> _carts = [];
  final List<ProductModel> _orders =[];


  void addCartProduct(ProductModel productModel) {
    _carts.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _carts.remove(productModel);
    notifyListeners();
  }
  void updateQuantity(ProductModel productModel,int quantity){
    int index = _carts.indexOf(productModel);
    _carts[index].quantity = quantity;
    notifyListeners();
  }
  double subtotal() {
    double re = 0.0;
    for (var p in _carts) {
      re += p.price * p.quantity!;
    }
    return re;
  }

  String get subtotalString => subtotal().toString();

  double deliveryFee(double subtotal) {
    if (subtotal > 500) {
      return 0.0;
    } else {
      return 150.5;
    }
  }

  String get deliveryFeeString => deliveryFee(subtotal()).toString();

  String freeDeliveryFee(double subtotal) {
    if (subtotal > 500) {
      return 'You have FREE Delivery';
    } else {
      double missing = 500 - subtotal;
      return 'Add ${missing.toString()} for Free Delivery';
    }
  }

  String get freedeliveryFreeString => freeDeliveryFee(subtotal());

  double total(double subtotal,double deliveryFee) {
    return subtotal + deliveryFee;
  }

  String get totalString =>
      total(subtotal(), deliveryFee(subtotal())).toString();

  List<ProductModel> get carts => _carts;
  


  
  List<ProductModel> get orders => _orders;

  void addOrderProduct(ProductModel productModel){
    _orders.add(productModel);
    notifyListeners();
  }
  void addOrderProductCart(){
    _orders.addAll(_carts);
   
    notifyListeners();
  }
  void clearsCart(){
    _carts.clear();
    notifyListeners();
  }
  void clearsOrder(){
    _orders.clear();
    notifyListeners();
  }
}
