import 'package:e_commerce/features/auth/controller/auth_controller.dart';
import 'package:e_commerce/features/category/screen/category_screen.dart';
import 'package:e_commerce/features/detail/screen/detail_screen.dart';
import 'package:e_commerce/features/home/controller/home_controller.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/models.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/widgets/product_item.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../constants/coloors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  final TextEditingController _searchProductController =
      TextEditingController();
  String text = '';
  bool showClose = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: KeyboardDismisser(
        gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection],
        child:  Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ecommerce',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    hintText: 'Search...',
                    controller: _searchProductController,
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            text = _searchProductController.text;
                          });

                          ref.invalidate(getProductsListSearchProvider(text));
                        },
                        icon: const Icon(Icons.search)),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          showClose = true;
                        });
                      } else {
                        setState(() {
                          showClose = false;
                        });
                      }
                    },
                    suffixIcon: showClose
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _searchProductController.clear();
                                showClose = false;
                                text = '';
                              });
                              ref.invalidate(getProductsListSearchProvider(''));
                            },
                            icon: const Icon(Icons.close))
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ref.watch(getCategoriesListProvider).when(
                        data: (categoriesList) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categoriesList.map((category) {
                                return Card(
                                  color: Coloors.whiteColor,
                                  shape: Border.all(
                                      width: 1, color: Coloors.greenColor),
                                  child: InkWell(
                                    onTap: () {
                                      AppRoute.push(
                                          widget: CategoryScreen(
                                            categoryModel: category,
                                          ),
                                          context: context);
                                    },
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            category.image,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const CircularProgressIndicator(),
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Best Products',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ref.watch(getProductsListSearchProvider(text)).when(
                        data: (productsList) {
                          return productsList.isNotEmpty
                              ? Expanded(
                                  child: GridView.builder(
                                    padding: const EdgeInsets.only(bottom: 50),
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.75,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20),
                                    shrinkWrap: true,
                                    itemCount: productsList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            AppRoute.push(
                                                widget: DetailScreen(
                                                    productModel:
                                                        productsList[index]),
                                                context: context);
                                          },
                                          child: ProductItem(
                                              productModel:
                                                  productsList[index]));
                                    },
                                  ),
                                )
                              : Text(
                                  'No product',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                );
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const CircularProgressIndicator(),
                      ),
                 
                ],
              ),
            ),
          ),
        
      )),
    );
  }
}
