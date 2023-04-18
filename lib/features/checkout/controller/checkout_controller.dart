import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart';
import '../repository/checkout_repository.dart';

final checkoutControllerProvider = Provider((ref) => CheckoutController(
    checkoutRepository: ref.watch(checkoutRepositoryProvider), ref: ref));

class CheckoutController {
  final CheckoutRepository _checkoutRepository;
  final ProviderRef _ref;
  CheckoutController(
      {required CheckoutRepository checkoutRepository,
      required ProviderRef ref})
      : _checkoutRepository = checkoutRepository,
        _ref = ref;

  Future<void> uploadOrderProduct(
      {required List<ProductModel> list,
      required BuildContext context,
      required String payment,
      required bool mounted}) async {
    return await _checkoutRepository.uploadOrderProduct(
        list: list,
        context: context,
        payment: payment,
        mounted: mounted,
        ref: _ref);
  }
}
