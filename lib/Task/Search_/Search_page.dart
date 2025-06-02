
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro1/Task/Home_/ProductSliders/Controller/getX_Controller.dart';
import 'package:pro1/Task/Home_/ProductSliders/Model/Product_model.dart';
import 'package:pro1/Task/Pages/ProDetails_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';

class Search_page extends StatefulWidget {
  const Search_page({super.key});

  @override
  State<Search_page> createState() => _Search_pageState();
}

class _Search_pageState extends State<Search_page> {
  final ProductController productController = Get.put(ProductController());
  TextEditingController searchController = TextEditingController();

  final String razorPayKey = "rzp_test_xH8lHTk2JMtS8k";
  final String razorPaySecret = "Q3XceCmcCk3ewdZf5G1mVtPM";

  late Razorpay _razorpay;

  String _sortOrder = 'none'; // none, asc, desc
  List<Product> search = [];

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
      "amount": (amount * 100).toInt(),
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
      return data['id'];
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
        'amount': (amount * 100).toInt(),
        'name': productName,
        'order_id': orderId,
        'description': description,
        'timeout': 90,
        'prefill': {
          'contact': '9955236973',
          'email': 'krajan92946@gmail.com'
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

  void _sortProductList(List<Product> products) {
    if (_sortOrder == 'asc') {
      products.sort((a, b) => (a.finalPrice ?? 0).compareTo(b.finalPrice ?? 0));
    } else if (_sortOrder == 'desc') {
      products.sort((a, b) => (b.finalPrice ?? 0).compareTo(a.finalPrice ?? 0));
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          search.clear();
                          for (var e in productController.ProductItems) {
                          if (e.productName != null &&
                              e.productName!.toLowerCase().contains(value.toLowerCase().trim())) {
                            search.add(e);
                          }
                        }
                          _sortProductList(search);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search any Product..",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.mic, color: Colors.grey),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Featured",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() {
                          _sortOrder = value;
                          // searchController=value;
                          if (searchController.text != "") {
                            _sortProductList(search);
                          } else {
                            _sortProductList(productController.ProductItems);
                          }
                        });
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 'asc', child: Text('Price: Low to High')),
                        PopupMenuItem(value: 'desc', child: Text('Price: High to Low')),
                      ],
                      child: _actionButton("Sort", Icons.swap_vert),
                    ),
                    SizedBox(width: 10),
                    _actionButton("Filter", Icons.filter_alt),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),

            // Scrollable Grid
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  List<Product> displayList = searchController.text != ""
                      ? List.from(search)
                      : List.from(productController.ProductItems);

                  _sortProductList(displayList);

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: displayList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 0,
                      mainAxisExtent: 350,
                    ),
                    itemBuilder: (context, index) {
                      final product = displayList[index];
                      final price = product.finalPrice ?? 0.0;

                      return InkWell(
                        onTap: () {
                          Get.to(ProductsDetailsPage(product: product));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                child: (product.images == null || product.images!.isEmpty)
                                    ? Container(
                                        color: Colors.redAccent,
                                        height: 120,
                                        width: double.infinity,
                                        child: const Center(child: Text("Image Not Found!")),
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
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text('₹${product.productPrice}',
                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 10),
                                        Text('${product.productDiscount}%',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                decoration: TextDecoration.lineThrough,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                    Text('₹ $price',
                                        style: const TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        ...List.generate(5, (index) => const Icon(Icons.star, size: 18, color: Colors.amber)),
                                        const SizedBox(width: 3),
                                        const Text("5.0", style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _openCheckout(
                                            product.finalPrice!.toDouble(),
                                            product.productName ?? "Product",
                                            product.description ?? "",
                                          );
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
            ),
          ],
        ),
      ),
    ),
  );
}


Widget _actionButton(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(width: 4),
        Icon(icon, size: 18),
      ],
    ),
  );
}
}