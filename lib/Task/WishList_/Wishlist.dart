
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pro1/Task/Category/Model/Cotegories_Model.dart';
import 'package:pro1/Task/Home_/ProductSliders/Controller/getX_Controller.dart';
import 'package:pro1/Task/Models/Categories.dart';
import 'package:pro1/Task/Pages/ProDetails_page.dart';
import 'package:pro1/Task/WishList_/Controller/Wishlist_Controller.dart';
import 'package:pro1/core/constants/api_network.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:pro1/Task/Category/CategoryProducts/Category_products.dart';
import 'package:pro1/Task/Category/Controller/Categories_controller.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final ProductController productController = Get.put(ProductController());
  final CategoriesController _categoriesController= Get.put(CategoriesController());
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
        'timeout': 60,
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Search any Product..",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(Icons.mic, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //Sort & Filter buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                   '${productController.ProductItems.length}+ Items',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      _actionButton("Sort", Icons.swap_vert),
                      const SizedBox(width: 10),
                      _actionButton("Filter", Icons.filter_alt),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Categories horizontal scroll
            Obx(
                 () {
                   return _categoriesController.isLoading.value? Center(child: CircularProgressIndicator()) : SizedBox(
                          height: 100,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                 List.generate(_categoriesController.Categories.length, (index) {
                                  CategoriesModel category = _categoriesController.Categories[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              ApiNetwork.imgUrl+category.categoryImage!
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                 Get.to(CategoryProducts(ID:category.id!,));
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            category.categoryName.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } ,)
                            ),
                          ),
                        );
                 }
               ),
// All produts
              Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: productController.ProductItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 0,
                      mainAxisExtent: 350,
                    ),
                    itemBuilder: (context, index) {
                      final product = productController.ProductItems[index];
                      final price = product.finalPrice ?? 0.0;

                      return InkWell(
                        onTap: (){
                          Get.to(ProductsDetailsPage(product: product,));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: (product.images == null || product.images!.isEmpty)
                                    ? Container(
                                        color: const Color.fromRGBO(185, 52, 42, 1),
                                        height: 120,
                                        width: double.infinity,
                                        child: const Center(
                                          child: Text("Image Not Found!"),
                                        ),
                                      )
                                    : Image.network(
                                        product.images![0].fullUrl! + "/small/" + product.images![0].image!,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,

                                      ),
                                      
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          '₹${product.productPrice.toString()}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${product.productDiscount} %',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            decoration: TextDecoration.lineThrough,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '₹ $price',
                                          style: const TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(5, (starIndex) {
                                            return const Icon(
                                              Icons.star,
                                              size: 18,
                                              color: Colors.amber,
                                            );
                                          }),
                                        ),
                                        const SizedBox(width: 3),
                                        const Text(
                                          "5.0",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (price <= 0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text("Invalid product price"),
                                              backgroundColor: Colors.red,
                                            ));
                                            return;
                                          }
                                          _openCheckout(product.finalPrice!.toDouble(), product.productName ?? "Product", product.description ?? "");
                                        },
                                        child: const Text("Buy Now"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      )),
    );
  }

  Widget _actionButton(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 4),
          Icon(icon, size: 18),
        ],
      ),
    );
  }

}
