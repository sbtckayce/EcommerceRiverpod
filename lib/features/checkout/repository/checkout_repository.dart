import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../../order/controller/order_controller.dart';

final checkoutRepositoryProvider = Provider((ref) => CheckoutRepository(
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
    firebaseAuth: ref.watch(firebaseAuthProvider)));

class CheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  CheckoutRepository(
      {required FirebaseFirestore firebaseFirestore,
      required FirebaseAuth firebaseAuth})
      : _firebaseFirestore = firebaseFirestore,
        _firebaseAuth = firebaseAuth;
  Future<void> uploadOrderProduct(
      {required List<ProductModel> list,
      required BuildContext context,
      required String payment,
      required bool mounted,
      required ProviderRef ref}) async {
    try {
      showLoadingDialog(context, 'Order');
      double total = 0.0;
      for (var element in list) {
        total += element.price * element.quantity!;
        if (total > 500) {
          total = total;
        } else {
          total = total + 150.5;
        }
      }

      DocumentReference documentReference = _firebaseFirestore
          .collection('userOrders')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('orders')
          .doc();
      DocumentReference admin = _firebaseFirestore.collection('orders').doc();

      await admin.set({
        'products': list.map((e) => e.toMap()),
        'status': 'pending',
        'total': total,
        'deliveryFee': total > 500 ? 0.0 : 150.5,
        'payment': payment,
        'orderId': admin.id
      });

      await documentReference.set({
        'products': list.map((e) => e.toMap()),
        'status': 'pending',
        'total': total,
        'deliveryFee': total > 500 ? 0.0 : 150.0,
        'payment': payment,
        'orderId': documentReference.id
      });
      ref.invalidate(getUserOrderProvider);
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      AppRoute.push(widget: const CustomBottomBar(), context: context);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      AppRoute.push(widget: const CustomBottomBar(), context: context);

      showMessage(e.toString());
    }
  }
}
