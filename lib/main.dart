import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/features/auth/screens/auth_screen.dart';
import 'package:shophere/providers/user_provider.dart';
import 'package:shophere/router.dart';

void main() {
  runApp(MultiProvider(providers : [
    ChangeNotifierProvider(create: (context) => UserProvider(),),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello'),
        ),
        body: Column(
          children: [
            const Center(
              child: Text('Flutter Demo Home Page'),
              ),
              Builder(
                builder: (context) {
                  return ElevatedButton(onPressed: () {
                    Navigator.pushNamed(context, AuthScreen.routeName);
                  }, child: const Text('click'));
                }
              )
          ],
        )),
    );
  }
}

