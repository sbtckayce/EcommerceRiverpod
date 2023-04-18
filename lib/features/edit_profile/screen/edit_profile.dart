import 'dart:io';

import 'package:e_commerce/features/edit_profile/controller/edit_profile_controller.dart';
import 'package:e_commerce/features/profile/controller/profile_controller.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../constants/constants.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key, required this.userModel});
  final UserModel userModel;
  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

 
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Coloors.whiteColor,
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Coloors.greenColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: KeyboardDismisser(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListView(
            children: [
              image == null
                  ? InkWell(
                      onTap: () {
                        takePicture();
                      },
                      child: const CircleAvatar(
                        radius: 60,
                        child: Icon(Icons.camera),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        takePicture();
                      },
                      child: CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 70,
                        
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(hintText: widget.userModel.name,controller: _nameController,
              ),
              const SizedBox(
                height: 10,
              ),

              CustomButton(
                  text: 'Update',
                  onPressed: () {
                    UserModel userModelNew = widget.userModel.copyWith(name: _nameController.text);
                    ref.read(editProfileControllerProvider).updateUserImage(
                        userModel: userModelNew,
                        context: context,
                        image: image!,
                        mounted: true);
                   
                    
                  })
            ],
          ),
        ),
      ),
    );
  }
}
