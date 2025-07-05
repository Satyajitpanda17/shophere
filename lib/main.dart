// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophere/common/widgets/bottom_nav_bar.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/features/admin/screens/admin_screen.dart';
import 'package:shophere/features/auth/screens/auth_screen.dart';
import 'package:shophere/features/auth/services/auth_service.dart';
import 'package:shophere/features/home/screens/home_screen.dart';
import 'package:shophere/providers/user_provider.dart';
import 'package:shophere/router.dart';

void main() {
  runApp(MultiProvider(providers : [
    ChangeNotifierProvider(create: (context) => UserProvider(),),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
   authService.getUserData(context).then((_) {
    setState(() {});  // rebuild so UI updates with user info
  });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: user.token.trim().isNotEmpty
        ? user.type.trim().toLowerCase() == 'admin'
            ? AdminScreen()
            : BottomNavBar()
        : const AuthScreen(),
    );
  }
}

