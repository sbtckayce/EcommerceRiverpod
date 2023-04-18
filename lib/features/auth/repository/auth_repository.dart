import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/widgets/custom_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
  ));

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firebaseFirestore,
     })
      : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore
      ;
  Stream<User?> get getAuthStateChange => _firebaseAuth.authStateChanges();

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context,
      required bool mounted}) async {
    try {
      showLoadingDialog(context, 'Login');
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (!mounted) return;
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const CustomBottomBar(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.slideUp,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
    }
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password,
      required BuildContext context,
      required bool mounted}) async {
    try {
      showLoadingDialog(context, 'Register');
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid, name: name, email: email, image: null);
      _firebaseFirestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toMap());

      if (!mounted) return;
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const CustomBottomBar(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.slideUp,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
    }
  }


}
