import 'package:e_commerce/features/order/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart';

final orderControllerProvider = Provider((ref) =>
    OrderController(orderRepository: ref.watch(orderRepositoryProvider),ref:ref));
final getUserOrderProvider =
    FutureProvider((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.getUserOrder();
});

class OrderController {
  final OrderRepository _orderRepository;
  final ProviderRef _ref;
  OrderController({required OrderRepository orderRepository,required ProviderRef ref})
      : _orderRepository = orderRepository,_ref=ref;

  

  Future<List<OrderModel>> getUserOrder() async {
    return await _orderRepository.getUserOrder();
  }
}
