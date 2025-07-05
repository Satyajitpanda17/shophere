import 'package:flutter/material.dart';
import 'package:shophere/features/admin/screens/add_product_screen.dart';
//import 'package:shophere/constants/global_variables.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {

  void navigateToAddProduct(){
  Navigator.pushNamed(context, AddProductScreen.routeName);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Products'
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,),
        onPressed: navigateToAddProduct,
        tooltip: 'Add a product',),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}