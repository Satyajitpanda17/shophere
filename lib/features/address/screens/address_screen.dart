import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:shophere/common/widgets/custom_button.dart';
import 'package:shophere/common/widgets/custom_textfield.dart';
import 'package:shophere/constants/global_variables.dart';
import 'package:shophere/constants/utils.dart';
import 'package:shophere/features/address/services/address_services.dart';
import 'package:shophere/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  late Future<PaymentConfiguration> _gpayConfigFuture;
  List<PaymentItem> paymentItems = [];
   String addressToBeUsed = "";

   final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
     _gpayConfigFuture = PaymentConfiguration.fromAsset('assets/gpay.json');
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

 @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

   void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider){
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        stateController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text} - ${stateController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    //var address = "A/190 Koelnagar";
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if(address.isNotEmpty)
              Column(
                children: [
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Form(
                        key: _addressFormKey,
                        child: Column(
                          children: [
                            CustomTextField(controller: flatBuildingController, hintText: 'Flat, House No. of BUilding'),
                            const SizedBox(height:10),
                            CustomTextField(controller: areaController, hintText: 'Area, Street'),
                            const SizedBox(height:10),
                            CustomTextField(controller: pincodeController, hintText: 'Pincode'),
                            const SizedBox(height:10),
                            CustomTextField(controller: cityController, hintText: 'City'),
                            const SizedBox(height:10),
                             CustomTextField(controller: stateController, hintText: 'State'),
                            const SizedBox(height:10),
                            FutureBuilder<PaymentConfiguration>(
                             future: PaymentConfiguration.fromAsset('gpay.json'),
                               builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                    return GooglePayButton(
                                      paymentConfiguration: snapshot.data!,
                                      paymentItems: paymentItems,
                                      onPaymentResult: onGooglePayResult,
                                      onError: (error) => print('Google Pay Error: $error'),
                                      height: 50,
                                      width: double.infinity,
                                      type: GooglePayButtonType.buy,
                                      theme: GooglePayButtonTheme.dark,
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Error loading GPay config: ${snapshot.error}');
                                  }

                                 return const CircularProgressIndicator();
                               },
                                )
                            ],
                        ),
                      ),
                ],
              ),
          ),
        ),
    );
  }
}