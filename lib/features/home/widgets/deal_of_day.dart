import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: Text('Deal of the Day',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          ),
        ),
        Image.network('https://plus.unsplash.com/premium_photo-1750681050012-cc6a960f28fd?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        height: 235,
        fit: BoxFit.fitHeight,),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left:15),
          child:  const Text('\$100',style: TextStyle(
            fontSize: 18,
          ),),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left:15,top: 5,right: 40),
          child: const Text(
            'Scene', maxLines: 2, overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Image.network('https://images.unsplash.com/photo-1751302386326-7eb6ae7ad39a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8RnpvM3p1T0hONnd8fGVufDB8fHx8fA%3D%3D',height: 100,width:100,fit: BoxFit.fitWidth,),
               SizedBox(width: 10,),
               Image.network('https://images.unsplash.com/photo-1751302386326-7eb6ae7ad39a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8RnpvM3p1T0hONnd8fGVufDB8fHx8fA%3D%3D',height:100,width:100,fit: BoxFit.fitWidth,),
               SizedBox(width: 10,),
               Image.network('https://images.unsplash.com/photo-1751302386326-7eb6ae7ad39a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8RnpvM3p1T0hONnd8fGVufDB8fHx8fA%3D%3D',height: 100,width:100,fit: BoxFit.fitWidth,),
               SizedBox(width: 10,),
               Image.network('https://images.unsplash.com/photo-1751302386326-7eb6ae7ad39a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8RnpvM3p1T0hONnd8fGVufDB8fHx8fA%3D%3D',height: 100,width:100,fit: BoxFit.fitWidth,),
          ],),
        ),
        Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
        ),
      ],
    );
  }
}