import 'package:e_commerce/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changePasswordRepositoryProvider = Provider((ref) =>
    ChangePasswordRepository(firebaseAuth: ref.watch(firebaseAuthProvider)));

class ChangePasswordRepository {
  final FirebaseAuth _firebaseAuth;
  ChangePasswordRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  Future<void> changePassword(
      {required String password,
      required BuildContext context,
      required bool mounted}) async {
    try {
      showLoadingDialog(context, 'Change password');
      await _firebaseAuth.currentUser!.updatePassword(password);
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pop(context);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pop(context);
      showMessage(e.toString());
    }
  }
}
