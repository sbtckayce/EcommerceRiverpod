
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:e_commerce/models/models.dart';

class OrderModel {
  String orderId;
  String payment;
  String status;
  double total;
  double deliveryFee;
  List<ProductModel> products;
  OrderModel({
    required this.orderId,
    required this.payment,
    required this.status,
    required this.total,
    required this.deliveryFee,
    required this.products,
  });
 

  OrderModel copyWith({
    String? orderId,
    String? payment,
    String? status,
    double? total,
    double? deliveryFee,
    List<ProductModel>? products,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      payment: payment ?? this.payment,
      status: status ?? this.status,
      total: total ?? this.total,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'payment': payment,
      'status': status,
      'total': total,
      'deliveryFee': deliveryFee,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ,
      payment: map['payment'] ,
      status: map['status'] ,
      total: map['total'] ,
      deliveryFee: map['deliveryFee'] ,
      products: List<ProductModel>.from((map['products'] ).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, payment: $payment, status: $status, total: $total, deliveryFee: $deliveryFee, products: $products)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.orderId == orderId &&
      other.payment == payment &&
      other.status == status &&
      other.total == total &&
      other.deliveryFee == deliveryFee &&
      listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
      payment.hashCode ^
      status.hashCode ^
      total.hashCode ^
      deliveryFee.hashCode ^
      products.hashCode;
  }
}
