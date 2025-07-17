import 'package:flutter/material.dart';
import 'package:shophere/common/loader.dart';
import 'package:shophere/features/admin/models/sales.dart';
import 'package:shophere/features/admin/services/admin_services.dart';
import 'package:shophere/features/admin/widgets/category_product_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
   final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
 var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
   return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(data: earnings!)
              )
            ],
          );
  }
}