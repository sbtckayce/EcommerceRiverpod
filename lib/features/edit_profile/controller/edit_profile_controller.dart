

import 'dart:io';

import 'package:e_commerce/features/edit_profile/repository/edit_profile_repository.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileControllerProvider =Provider((ref) => EditProfileController(editProfileRepository: ref.watch(editProfileRepositoryProvider),ref: ref));

class EditProfileController {
  final EditProfileRepository _editProfileRepository;
  final ProviderRef _ref;
  EditProfileController({required EditProfileRepository editProfileRepository,
  required ProviderRef ref}):_editProfileRepository =editProfileRepository,_ref=ref;

  Future<void> updateUserImage({required UserModel userModel,required File image,required BuildContext context,required bool mounted,}) async{
    return await _editProfileRepository.updateUserImage(userModel:userModel,image:image,context:context,mounted: mounted, ref: _ref);
  }
 
}