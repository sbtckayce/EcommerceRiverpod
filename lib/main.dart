import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/auth/controller/auth_controller.dart';
import 'package:e_commerce/features/home/screen/home_screen.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/features/auth/screens/login_screen.dart';
import 'package:e_commerce/widgets/custom_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/welcome/screen/welcome_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: StreamBuilder(
        stream: ref.watch(authControllerProvider).getAuthStateChange,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return CustomBottomBar();
          }
          return WelcomeScreen();
        },
      ),

    );
  }
}

