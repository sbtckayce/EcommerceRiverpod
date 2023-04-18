import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/change_password/controller/change_password_controller.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  bool isPassword = true;
  bool isConfirmPassword = true;
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
       gestures: const [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
        title: Text(
          'Change password',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Coloors.greenColor, fontWeight: FontWeight.bold),
        ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Center(
              child: Column(
            children: [
              CustomTextFormField(
                  isPassword: isPassword,
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: isPassword
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off)),
                  hintText: 'New password'),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                  isPassword: isPassword,
                  controller: _confirmPasswordController,
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPassword = !isConfirmPassword;
                        });
                      },
                      icon: isConfirmPassword
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off)),
                  hintText: 'Confirm password'),
                   const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Update',
                onPressed: () {
                  if (_passwordController.text.isEmpty) {
                    showMessage('Password is not empty');
                  } else if (_confirmPasswordController.text.isEmpty) {
                    showMessage('Confirm password is not empty');
                  } else if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    showMessage('Confirm password must same password');
                  } else {
                    ref.read(changePasswordControllerProvider).changePassword(password: _passwordController.text, 
                    context: context, mounted: true);
                  }
                },
              )
            ],
          )),
        ),
      ),
    );
  }
}
