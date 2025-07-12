import 'package:flutter/material.dart';
import 'package:shophere/common/widgets/bottom_nav_bar.dart';
import 'package:shophere/features/address/screens/address_screen.dart';
import 'package:shophere/features/admin/screens/add_product_screen.dart';
import 'package:shophere/features/admin/screens/admin_screen.dart';
import 'package:shophere/features/auth/screens/auth_screen.dart';
import 'package:shophere/features/home/screens/category_deals_screen.dart';
import 'package:shophere/features/home/screens/home_screen.dart';
import 'package:shophere/features/product_details/screens/product_details_screen.dart';
import 'package:shophere/features/search/screens/search_screen.dart';
import 'package:shophere/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName : return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => const AuthScreen(),
      );
      case HomeScreen.routeName : return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => const HomeScreen(),
      );
      case BottomNavBar.routeName : return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => const BottomNavBar(),
      );
      case AdminScreen.routeName : return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => const AdminScreen(),
      );
      case AddProductScreen.routeName : return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => const AddProductScreen(),
      );
      case CategoryDealsScreen.routeName :
      var category = routeSettings.arguments as String;
       return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => CategoryDealsScreen(category : category),
      );
      case SearchScreen.routeName :
      var searchQuery = routeSettings.arguments as String;
       return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => SearchScreen(searchQuery: searchQuery,),
      );
      case ProductDetailsScreen.routeName :
      var product = routeSettings.arguments as Product;
       return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => ProductDetailsScreen(product: product,),
      );
      case AddressScreen.routeName : 
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => AddressScreen(totalAmount: totalAmount,),
      );
    default : return MaterialPageRoute(builder: (_) => const Scaffold(
      body: Center(child: Text('No such page exists'))
    ));
  }
}