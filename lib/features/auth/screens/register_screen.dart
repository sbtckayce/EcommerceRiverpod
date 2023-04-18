import 'package:e_commerce/features/auth/controller/auth_controller.dart';
import 'package:e_commerce/features/home/screen/home_screen.dart';
import 'package:e_commerce/widgets/top_titles.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../routes/routes.dart';

import 'login_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  title: 'Create Account', subTitle: 'Welocom to Store'),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: 'Name',
                controller: _nameController,
                prefixIcon: const Icon(Icons.person_2_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: 'Email',
                controller: _emailController,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: 'Phone',
                textInputType: TextInputType.phone,
                controller: _phoneController,
                prefixIcon: const Icon(Icons.call),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: 'Password',
                controller: _passwordController,
                isPassword: isPassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: isPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
                prefixIcon: const Icon(Icons.password_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                text: 'REGISTER',
                onPressed: () {
                  bool isValidated = registerVaildation(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                      _phoneController.text);
                  if (isValidated) {
                    ref.read(authControllerProvider).register(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                        mounted: true);
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                'Already have an acount',
                style: Theme.of(context).textTheme.titleSmall,
              )),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      AppRoute.push(widget: LoginScreen(), context: context);
                    },
                    child: Text(
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Coloors.greenColor),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
