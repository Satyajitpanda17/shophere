import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophere/constants/error_handler.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/constants/utils.dart';
import 'package:shophere/features/admin/screens/products_screen.dart';
import 'package:shophere/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shophere/providers/user_provider.dart';

class AdminServices{
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  })async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dxutlvjv6', 'shophere');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name, 
        description: description, 
        quantity: quantity, 
        images: imageUrls, 
        category: category, 
        price: price);

      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token,
        },
        body : product.toJson(),
        );
        httpErrorHandle(response: res, context: context, onSuccess: (){
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => PostsScreen()),
);
        });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
  try {
    http.Response res = await http.get(Uri.parse('$uri/admin/get-Products'),
    headers : {
        'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token,
    });
     httpErrorHandle(response: res, context: context, onSuccess: (){
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        });
  } catch (e) {
    
    showSnackBar(context, e.toString());
  }
   return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess
  }) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      try {
        http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
      } catch (e) {
        showSnackBar(context, e.toString());
      }
}
}