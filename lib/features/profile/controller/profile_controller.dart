import 'package:e_commerce/features/profile/repository/profile_repository.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileControllerProvider = Provider((ref) =>
    ProfileController(profileRepository: ref.watch(profileRepositoryProvider)));

final getInfoUserProvider = FutureProvider<UserModel>((ref) {
  final profileController = ref.watch(profileControllerProvider);
  return profileController.getInfoUser();
});
class ProfileController {
  final ProfileRepository _profileRepository;

  ProfileController({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  Future<UserModel> getInfoUser() async {
    return await _profileRepository.getInfoUser();
  }
  void signOut({required BuildContext context, required bool mounted}) {
    _profileRepository.signOut(context: context, mounted: mounted);
  }
}
