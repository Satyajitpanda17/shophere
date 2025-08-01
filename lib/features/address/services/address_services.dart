import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophere/constants/error_handler.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/constants/utils.dart';
import 'package:shophere/models/user.dart';
import 'package:shophere/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
     http.Response res = await http.post(Uri.parse('$uri/api/save-address'),
      headers : {
        'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'address' : address,
      }),
      );

      httpErrorHandle(response: res, 
      context: context, 
      onSuccess: (){
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
      userProvider.setUserFromModel(user);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

   void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
     http.Response res = await http.post(Uri.parse('$uri/api/place-order'),
      headers : {
        'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'cart': userProvider.user.cart,
          'address': address,
           'totalPrice': totalSum,
      }),
  
      );
 print(res.body);
      httpErrorHandle(response: res, 
      context: context, 
      onSuccess: (){
           showSnackBar(context, 'Your order has been placed!');
          User user = userProvider.user.copyWith(
            cart: [],
          );
      userProvider.setUserFromModel(user);
      },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}