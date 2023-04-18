import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/order/controller/order_controller.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/widgets/custom_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart';

final orderRepositoryProvider = Provider((ref) => OrderRepository(
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
    firebaseAuth: ref.watch(firebaseAuthProvider)));

class OrderRepository{
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;


  OrderRepository(
      {required FirebaseFirestore firebaseFirestore,
      required FirebaseAuth firebaseAuth})
      : _firebaseFirestore = firebaseFirestore,
        _firebaseAuth = firebaseAuth;



  Future<List<OrderModel>> getUserOrder() async {
    try {
     
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('userOrders')
              .doc(_firebaseAuth.currentUser!.uid)
              .collection('orders')
              .get();

      List<OrderModel> orderList =
          querySnapshot.docs.map((e) => OrderModel.fromMap(e.data())).toList();
      return orderList;
    } catch (e) {
      showMessage(e.toString());
     
      return [];
    }
  }
}
