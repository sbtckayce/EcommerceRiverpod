import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../models/user_model.dart';
final profileRepositoryProvider = Provider((ref) => ProfileRepository(firebaseFirestore: ref.watch(firebaseFirestoreProvider), 
firebaseAuth: ref.watch(firebaseAuthProvider)));


class ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  ProfileRepository(
      {required FirebaseFirestore firebaseFirestore,
      required FirebaseAuth firebaseAuth})
      : _firebaseFirestore = firebaseFirestore,
        _firebaseAuth = firebaseAuth;

  Future<UserModel> getInfoUser() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection('users')
            .doc(_firebaseAuth.currentUser!.uid)
            .get();
    return UserModel.fromMap(querySnapshot.data()!);
  }
  void signOut({required BuildContext context,required bool mounted}) async {
    try {
      showLoadingDialog(context, 'Sign out');
      await _firebaseAuth.signOut();
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
       Navigator.of(context).pop();
      showMessage(e.toString());
    }
  }
}
