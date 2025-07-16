import 'package:flutter/material.dart';
import 'package:shophere/common/loader.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/features/account/services/account_services.dart';
import 'package:shophere/features/account/widgets/single_product.dart';
import 'package:shophere/features/order_details/screens/order_details_screen.dart';
import 'package:shophere/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }
void fetchOrders() async {
   orders = await accountServices.fetchMyOrders(context: context);
}

  @override
  Widget build(BuildContext context) {
    return orders == null ? const Loader() : Column(
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
                itemCount: orders!.length,
                itemBuilder:(context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: orders![index]);
                    },
                    child: SingleProduct(image: orders![index].products[0].images[0]));
                })
                ),               
      ],
    );
  }
}