import 'package:flutter/material.dart';
import 'package:shophere/common/loader.dart';
import 'package:shophere/features/home/services/home_services.dart';
import 'package:shophere/features/product_details/screens/product_details_screen.dart';
import 'package:shophere/models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

   void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null 
    ? const Loader() 
    : product!.name.isEmpty 
    ? const SizedBox() 
    : GestureDetector(
      onTap : navigateToDetailScreen,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15),
            child: Text('Deal of the Day',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            ),
          ),
          Image.network(
              product!.images[0],
              height: 235,
              fit: BoxFit.fitHeight,
              ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left:15),
            child:  const Text('\$100',style: TextStyle(
              fontSize: 18,
            ),),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left:15,top: 5,right: 40),
            child: const Text(
              'Satts', maxLines: 2, overflow: TextOverflow.ellipsis,
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: product!.images
                            .map(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                width: 100,
                                height: 100,
                              ),
                            )
                            .toList(),
                      ),
          ),
          Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ).copyWith(left: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'See all deals',
                          style: TextStyle(
                            color: Colors.cyan[800],
                          ),
                        ),
          ),
        ],
      ),
    );
  }
}