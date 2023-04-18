import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/profile/controller/profile_controller.dart';
import 'package:e_commerce/features/profile/screen/profile_screen.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileRepositoryProvider = Provider((ref) => EditProfileRepository(
    firebaseStorage: ref.watch(firebaseStorageProvider),
    firebaseAuth: ref.watch(firebaseAuthProvider),
    firebaseFirestore: ref.watch(firebaseFirestoreProvider)));

class EditProfileRepository {
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  EditProfileRepository(
      {required FirebaseStorage firebaseStorage,
      required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firebaseFirestore})
      : _firebaseStorage = firebaseStorage,
        _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  Future<void> updateUserImage(
      {required UserModel userModel,
      required File image,
      required BuildContext context,
      required bool mounted,
      required ProviderRef ref}) async {
    try {
      showLoadingDialog(context, 'Update user');

      String userId = _firebaseAuth.currentUser!.uid;
      TaskSnapshot taskSnapshot =
          await _firebaseStorage.ref(userId).putFile(image);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      UserModel userModelNew = userModel.copyWith(image: imageUrl);
      await _firebaseFirestore
          .collection('users')
          .doc(userModelNew.id)
          .set(userModelNew.toMap());

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      ref.invalidate(getInfoUserProvider);
      Navigator.pop(context);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();

      Navigator.pop(context);
      showMessage(e.toString());
    }
  }
}
