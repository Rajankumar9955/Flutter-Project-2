import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro1/Task/Home_/ProductSliders/Controller/getX_Controller.dart';
import 'package:get/get.dart';
import 'package:pro1/Task/Pages/ProDetails_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductSlider extends StatefulWidget {
  ProductSlider({super.key});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  final ProductController productController = Get.put(ProductController());
  int count = 0;
  late Razorpay _razorpay;

  // Replace with your Razorpay Test Key and Secret.
  final String razorPayKey = "rzp_test_xH8lHTk2JMtS8k";
  final String razorPaySecret = "Q3XceCmcCk3ewdZf5G1mVtPM"; // Should be stored securely and used on backend

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Payment Success: ${response.paymentId}"),
      backgroundColor: Colors.green,
    ));
    print(response.data);
    // Additional logic after success e.g. update UI, confirm order
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Payment Failed: ${response.message}"),
      backgroundColor: Colors.red,
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("External Wallet Selected: ${response.walletName}"),
      backgroundColor: Colors.orange,
    ));
  }

  Future<String> _createOrder(double amount) async {
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$razorPayKey:$razorPaySecret'));

    final Map<String, dynamic> body = {
      "amount": (amount * 100).toInt(), // Amount in paise
      "currency": "INR",
      "receipt": "receipt_${DateTime.now().millisecondsSinceEpoch}",
      "payment_capture": 1
    };

    final Uri url = Uri.parse('https://api.razorpay.com/v1/orders');

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
        body: json.encode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['id']; // order_id from Razorpay
    } else {
      throw Exception('Failed to create order: ${response.body}');
    }
  }

  void _openCheckout(double amount, String productName, String description) async {
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid product amount."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      final String orderId = await _createOrder(amount);
      var options = {
        'key': razorPayKey,
        'amount': (amount * 100).toInt(), // in paise
        'name': productName,
        'order_id': orderId,
        'description': description,
        'timeout': 90,
        'prefill': {
          'contact': '9955236973', // Optionally, get from user profile
          'email': 'krajan92946@gmail.com' // Optionally, get from user profile
        },
      };

      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${e.toString()}"),
        backgroundColor: Colors.red,
      ));
    }
  }

    
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return productController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : SizedBox(
            height: 360,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: productController.ProductItems.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final product = productController.ProductItems[index];
                final price = product.finalPrice ?? 0.0;
                return InkWell(
                          onTap: (){
                             Get.to(ProductsDetailsPage(product: product,));
                          },
                  child: Container(
                      
                    width: 250,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child:
                          product.images!.isEmpty ||product.images==null ? 
                          Container(
                            child: Center( child: Text("Image Not Found!"),),
                            color: const Color.fromRGBO(185, 52, 42, 1,),height: 150,width: double.infinity,)
                           :Image.network(
                            product.images![0].fullUrl! +
                                "/small/" +
                                product.images![0].image!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                 product.productName.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  
                              SizedBox(height: 5),
                              Text(
                                product.description.toString(),
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                   '₹${product.productPrice.toString()}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${product.productDiscount} %',
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '₹ ${product.finalPrice}',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(5, (starIndex) {
                                      return Icon(
                                        Icons.star,
                                        size: 18,
                                        // color: starIndex < kurta['rating']
                                        //     ? Colors.amber
                                        //     : Colors.grey,
                                      );
                                    }),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "5 Star",
                                    style: TextStyle(color: Colors.grey),
                                  ), 
                                ],
                                
                              ),
                              SizedBox(height:5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                       ElevatedButton(onPressed: (){
                                        
                                            if (price <= 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("Invalid product price"),
                                            backgroundColor: Colors.red,
                                          ));
                                          return;
                                        }
                                        _openCheckout(product.finalPrice!.toDouble(), product.productName ?? "Product", product.description ?? "");
                                       }, child: Text("Buy Now")),


                                        ElevatedButton(onPressed: (){
                                               print("You Clicked the Add to Cart Button");
                                       }, child: Text("Add to Cart")),
                                    ],
                                  )
                            ],
                          ),
                        ),
                      ],
                    ),
                  
                  ),
                );
              },
            ),
          );
    });
  }
}
