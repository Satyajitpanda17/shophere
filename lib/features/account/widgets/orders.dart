import 'package:flutter/material.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/features/account/widgets/single_product.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                      'Your Orders',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                      'See all',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
            )
          ],
        ),
        //display orders of the user
        Container(height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder:(context,index){
                  return SingleProduct(image: list[index]);
                })
                ),               
      ],
    );
  }
}