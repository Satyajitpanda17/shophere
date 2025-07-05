import 'package:flutter/material.dart';
import 'package:shophere/common/widgets/bottom_nav_bar.dart';
import 'package:shophere/features/admin/screens/add_product_screen.dart';
import 'package:shophere/features/admin/screens/admin_screen.dart';
import 'package:shophere/features/auth/screens/auth_screen.dart';
import 'package:shophere/features/home/screens/home_screen.dart';

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
    default : return MaterialPageRoute(builder: (_) => const Scaffold(
      body: Center(child: Text('No such page exists'))
    ));
  }
}