import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shophere/constants/error_handler.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/constants/utils.dart';
import 'package:shophere/models/order.dart';
import 'package:shophere/models/product.dart';
import 'package:shophere/providers/user_provider.dart';

class AccountServices{

  Future<List<Order>> fetchMyOrders({
  required BuildContext context
}) async {
  final userProvider = Provider.of<UserProvider>(context,listen:false);
  List<Order> orderList = [];
  try {
    http.Response res = await http.get(Uri.parse('$uri/api/orders/me'),
    headers : {
      'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
    });
    // print("hello");
    // print(res.body);
   if(res.statusCode == 200 && res.body.isNotEmpty){
     httpErrorHandle(response: res, context: context, onSuccess: (){
      final decoded = jsonDecode(res.body);
      orderList = List<Order>.from(
        decoded.map((item) => Order.fromJson(jsonEncode(item))),
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
  return orderList;
}
}