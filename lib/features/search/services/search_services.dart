import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophere/constants/error_handler.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/constants/utils.dart';
import 'package:shophere/models/product.dart';
import 'package:shophere/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {

  Future<List<Product>> fetchSearchedProduct({
  required BuildContext context,
  required String searchQuery
}) async {
  final userProvider = Provider.of<UserProvider>(context,listen:false);
  List<Product> productList = [];
  try {
    http.Response res = await http.get(Uri.parse('$uri/api/products/search/$searchQuery'),
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
     //print('Error: ${res.statusCode}, Body: ${res.body}');
  showSnackBar(context, 'Failed to fetch products');
   }
  } catch (e) {
    print(e.toString());
     showSnackBar(context, e.toString());
  }
  return productList;
}
}
