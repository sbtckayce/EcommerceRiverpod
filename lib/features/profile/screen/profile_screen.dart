import 'package:e_commerce/features/auth/controller/auth_controller.dart';
import 'package:e_commerce/features/change_password/screen/change_password_screen.dart';
import 'package:e_commerce/features/edit_profile/screen/edit_profile.dart';
import 'package:e_commerce/features/profile/controller/profile_controller.dart';
import 'package:e_commerce/features/wishlist/screen/wishlist_screen.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
         centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Coloors.greenColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            ref.watch(getInfoUserProvider).when(
                  data: (userModel) {
                    return Expanded(
                        child: Column(
                      children: [
                        InkWell(
                               onTap: () {
                                  AppRoute.push(
                                      widget: EditProfile(userModel: userModel),
                                      context: context);
                                },
                              child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: userModel.image !=null ? NetworkImage(userModel.image!) : const NetworkImage('https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg'),
                                ),
                            ),
                        Text(
                          userModel.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          userModel.email,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ));
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.shopping_bag_outlined),
                      title: Text('Your Orders'),
                    ),
                    ListTile(
                      onTap: (){
                        AppRoute.push(widget:const WishlistScreen(), context: context);
                      },
                      leading: Icon(Icons.favorite_outline),
                      title: Text('Favourite'),
                    ),
                    ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('About us'),
                    ),
                    ListTile(
                      leading: Icon(Icons.support),
                      title: Text('Support'),
                    ),
                     ListTile(
                      onTap: (){
                        AppRoute.push(widget:const ChangePasswordScreen(), context: context)
                    ;  },
                      leading:const Icon(Icons.change_circle),
                      title:const Text('Change password'),
                    ),
                    ListTile(
                      onTap: () {
                        ref.read(profileControllerProvider).signOut(context: context,mounted: true);
                       
                      },
                      leading:const Icon(Icons.exit_to_app),
                      title: const Text('Log out'),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
