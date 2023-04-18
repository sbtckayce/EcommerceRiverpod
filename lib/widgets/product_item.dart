import 'package:e_commerce/models/models.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: Coloors.greenColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 120,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  
                  child: Image.network(
                    productModel.image,
                    fit: BoxFit.cover,
                  ))),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productModel.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10,),
              Text(
                '\$${productModel.price}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
         
        ],
      ),
    );
  }
}
