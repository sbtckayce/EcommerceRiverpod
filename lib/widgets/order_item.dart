import 'package:e_commerce/constants/coloors.dart';
import 'package:e_commerce/models/models.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 2, color: Coloors.greenColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Id : ${orderModel.orderId}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Payment : ${orderModel.payment}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status : ${orderModel.status}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Delivery fee : ${orderModel.deliveryFee}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              flex: 2,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: orderModel.products.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Coloors.greenColor)),
                    child: Row(children: [
                      Image.network(
                        orderModel.products[index].image,
                        width: 50,
                        height: 50,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(orderModel.products[index].name,
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                Text(
                                  '\$${orderModel.products[index].price.toString()}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              ],
                            ),
                            Text(
                              orderModel.products[index].quantity.toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                    ]),
                  );
                },
              )),
          Expanded(
            child: Text(
              'Total : ${orderModel.total}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
