import 'package:e_commerce/features/auth/controller/auth_controller.dart';
import 'package:e_commerce/features/home/screen/home_screen.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
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
                  title: 'Login', subTitle: 'Welcome back to Store'),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: 'Email',
                  controller: _emailController),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                  prefixIcon: const Icon(Icons.password_sharp),
                  hintText: 'Password',
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
                  controller: _passwordController),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                text: 'LOGIN',
                onPressed: () {
                  bool isValidated = loginVaildation(
                      _emailController.text, _passwordController.text);
                  if (isValidated) {
                    ref.read(authControllerProvider).login(
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
                'Don\'t have an account ?',
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
                      AppRoute.push(widget: RegisterScreen(), context: context);
                    },
                    child: Text(
                      'Register',
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
