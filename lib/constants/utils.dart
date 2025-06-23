import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String txt){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(txt)),
  );
}