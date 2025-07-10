import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shophere/common/widgets/bottom_nav_bar.dart';
import 'package:shophere/constants/error_handler.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/constants/utils.dart';
//import 'package:shophere/features/home/screens/home_screen.dart';
import 'package:shophere/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shophere/providers/user_provider.dart';
class AuthService{
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  })async {
    try{
      User user = User(
        id:'',
        name: name, 
        email: email, 
        password: password, 
        address: '', 
        type: '', 
        token: '',
        cart : [],);

        http.Response res = await http.post(Uri.parse('$uri/api/signup'), 
        body: user.toJson(),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
    });
    httpErrorHandle(response: res , context: context, onSuccess: (){
        showSnackBar(context, 'Account has been created successfully !\n Login with same credentials');
       });
    }catch(e){
        showSnackBar(context, e.toString());
    }
  }

   void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  })async {
    try{
        http.Response res = await http.post(Uri.parse('$uri/api/signin'), 
        body: jsonEncode({
          'email' : email,
          'password' : password
        }),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
    });
    httpErrorHandle(response: res , context: context, onSuccess: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider.of<UserProvider>(context, listen:false).setUser(res.body);
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        showSnackBar(context, 'Logged In successfully !');
        Navigator.pushNamedAndRemoveUntil(context, BottomNavBar.routeName, (route) => false,);
       });
    }catch(e){
        showSnackBar(context, e.toString());
    }
  }

 Future<void> getUserData(
    BuildContext context,
  )async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final rp = await http.get(
  Uri.parse('$uri/'),
  headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'x-auth-token': token!,
  },
).timeout(Duration(seconds: 10));
//print(rp.body);
      if(token == null){
        prefs.setString('x-auth-token', '');
        }
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
      headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token' : token!
    });

    var response = jsonDecode(tokenRes.body);
    if(response == true){
      http.Response userRes = await http.get(Uri.parse('$uri/'),
      headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token' : token
    });
    var userProvider =  Provider.of<UserProvider>(context, listen:false);
    userProvider.setUser(userRes.body);
    }
    }catch(e){
        showSnackBar(context, e.toString());
    }
  }
}
