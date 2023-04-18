import 'package:e_commerce/features/change_password/repository/change_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changePasswordControllerProvider = Provider((ref) =>
    ChangePasswordController(
        changePasswordRepository: ref.watch(changePasswordRepositoryProvider)));

class ChangePasswordController {
  final ChangePasswordRepository _changePasswordRepository;
  ChangePasswordController(
      {required ChangePasswordRepository changePasswordRepository})
      : _changePasswordRepository = changePasswordRepository;

  Future<void> changePassword(
      {required String password,
      required BuildContext context,
      required bool mounted}) async {
    return await _changePasswordRepository.changePassword(
        password: password, context: context, mounted: mounted);
  }
}
