import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pro2/Task/Home/Bloc/product_bloc.dart';
import 'package:pro2/Task/Home/Bloc/product_event.dart';
import 'package:pro2/Task/Home/Bloc/product_state.dart';
import 'package:pro2/Task/Model/product_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class CategoryProducts extends StatefulWidget {
  final int ID;
  CategoryProducts({super.key, required this.ID});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {

  final ProductBloc _productBloc=ProductBloc();
  late Razorpay _razorpay;

  final String razorPayKey = "rzp_test_xH8lHTk2JMtS8k";
  final String razorPaySecret = "Q3XceCmcCk3ewdZf5G1mVtPM";

  @override
  void initState() {
    super.initState();
    _productBloc.add(GetProductsEvent());
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Success: ${response.paymentId}"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Failed: ${response.message}"),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("External Wallet Selected: ${response.walletName}"),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<String> _createOrder(double amount) async {
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$razorPayKey:$razorPaySecret'));

    final Map<String, dynamic> body = {
      "amount": (amount * 100).toInt(),
      "currency": "INR",
      "receipt": "receipt_${DateTime.now().millisecondsSinceEpoch}",
      "payment_capture": 1,
    };

    final Uri url = Uri.parse('https://api.razorpay.com/v1/orders');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': basicAuth},
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['id'];
    } else {
      throw Exception('Failed to create order: ${response.body}');
    }
  }

  void _openCheckout(
    double amount,
    String productName,
    String description,
  ) async {
    try {
      final String orderId = await _createOrder(amount);
      var options = {
        'key': razorPayKey,
        'amount': (amount * 100).toInt(),
        'name': productName,
        'order_id': orderId,
        'description': description,
        'timeout': 60,
        'prefill': {
          'contact': '9955236973',
          'email': 'krajan92946@gmail.com',
        },
      };

      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: SingleChildScrollView(
            child: 

         BlocBuilder<ProductBloc, ProductState>(
          bloc: _productBloc,
          builder:(context , state){
            if(state is ProductInitial || state is ProductLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(state is ProductLoaded){
               List<ProductModel> data = state.productsList
                  .where((product) => product.categoryId == widget.ID)
                  .toList();

              return Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data.length}+Items',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                data.isEmpty
                 ? Center(
                     child: Padding(
                       padding: const EdgeInsets.only(top: 100),
                       child: Text(
                         "No products found in this category.",
                         style: TextStyle(fontSize: 18, color: Colors.grey),
                       ),
                     ),
                   )
                 : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: data.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 0,
                      mainAxisExtent: 350,
                    ),
                    itemBuilder: (context, index) {
                      final product = data[index];
                      final price = product.finalPrice ?? 0.0;

                      return InkWell(
                        // onTap: () => Get.to(ProductsDetailsPage(product: product)),
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
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: (product.images == null || product.images!.isEmpty)
                                    ? Container(
                                        color: const Color.fromRGBO(185, 52, 42, 1),
                                        height: 120,
                                        width: double.infinity,
                                        child: const Center(child: Text("Image Not Found!")),
                                      )
                                    : Image.network(
                                        product.images![0].fullUrl! +
                                            "/small/" +
                                            product.images![0].image!,
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
                                      product.productName ?? "",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          '₹${product.productPrice ?? 0}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${product.productDiscount ?? 0} %',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            decoration: TextDecoration.lineThrough,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '₹ $price',
                                          style: const TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(5, (index) {
                                            return const Icon(Icons.star, size: 18, color: Colors.amber);
                                          }),
                                        ),
                                        const SizedBox(width: 3),
                                        const Text(
                                          "5.0",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (price <= 0) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("Invalid product price"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }
                                          _openCheckout(price.toDouble(), product.productName ?? "", product.description ?? "");
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
                  ),
                ],
              );
            }else if(state is ProductError){
              return Center(
                child: Text("SomeThing Went Wrong!"),
              );
            }
             return Container();
         }),
             
          ),
        ),
      ),
    );
  }
}
