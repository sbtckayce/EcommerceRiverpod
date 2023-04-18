import 'package:e_commerce/features/home/controller/home_controller.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../routes/routes.dart';
import '../../../widgets/product_item.dart';
import '../../detail/screen/detail_screen.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: Text(widget.categoryModel.name,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Coloors.greenColor,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.categoryModel.id),
            const SizedBox(height: 20,),
            ref
                .watch(
                    getProductListFromCategoryProvider(widget.categoryModel.id))
                .when(
                  data: (productsList) {
                    return Expanded(
                      child: GridView.builder(
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
                                        productModel: productsList[index]),
                                    context: context);
                              },
                              child:
                                  ProductItem(productModel: productsList[index]));
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
          ],
        ),
      ),
    );
  }
}
