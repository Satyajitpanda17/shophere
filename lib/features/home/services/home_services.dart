import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophere/constants/error_handler.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/constants/utils.dart';
import 'package:shophere/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shophere/providers/user_provider.dart';

class HomeServices{

  //fetch products according to category
Future<List<Product>> fetchCategoryProducts({
  required BuildContext context,
  required String category
}) async {
  final userProvider = Provider.of<UserProvider>(context,listen:false);
  List<Product> productList = [];
  try {
    http.Response res = await http.get(Uri.parse('$uri/api/products?category=$category'),
    headers : {
      'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
    });
    // print("hello");
    // print(res.body);
   if(res.statusCode == 200 && res.body.isNotEmpty){
     httpErrorHandle(response: res, context: context, onSuccess: (){
      final decoded = jsonDecode(res.body);
      productList = List<Product>.from(
        decoded.map((item) => Product.fromJson(jsonEncode(item))),
      );
    });
   }else{
    //  print('Error: ${res.statusCode}, Body: ${res.body}');
  showSnackBar(context, 'Failed to fetch products');
   }
  } catch (e) {
    print(e.toString());
     showSnackBar(context, e.toString());
  }
  return productList;
}

//deal of the day
Future<Product> fetchDealOfDay({
  required BuildContext context,
}) async{
  final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );
    try {
      http.Response res = await http.get(Uri.parse('$uri/api/deal-of-the-day'),
      headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
        response: res, 
        context: context, onSuccess: (){
          product = Product.fromJson(res.body);
        },
        );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  return product;
}
}