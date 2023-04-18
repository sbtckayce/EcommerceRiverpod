
import 'package:e_commerce/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import '../../auth/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                title: 'Welcome',
                subTitle: 'Buy AnyItems From Using App',
              ),
              const Spacer(),
              SizedBox(
                height: 300,
                child: Center(
                    child: Image.asset(
                  'assets/images/welcome.png',
                )),
              ),
              const Spacer(),
              CustomButton(
                text: 'Get Starting',
                onPressed: () {
                AppRoute.push(widget: LoginScreen(), context: context);
                },
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
