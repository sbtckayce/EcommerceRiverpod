import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider(
    (ref) => AuthController(authRepository: ref.watch(authRepositoryProvider)));

class AuthController {
  final AuthRepository _authRepository;
  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context,
      required bool mounted}) async {
    try {
      return await _authRepository.login(
          email: email, password: password, context: context, mounted: mounted);
    } on FirebaseAuthException catch (e) {
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
      return await _authRepository.register(
          name: name,
          email: email,
          password: password,
          context: context,
          mounted: mounted);
    } on FirebaseAuthException catch (e) {
      showMessage(e.code.toString());
    }
  }

 
  Stream<User?> get getAuthStateChange => _authRepository.getAuthStateChange;
}
