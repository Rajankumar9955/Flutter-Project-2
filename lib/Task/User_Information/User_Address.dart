



import 'package:flutter/material.dart';
import 'package:pro1/Task/User_Information/Controller/User_Controllers.dart';
import 'package:get/get.dart';

class UserAddress extends StatefulWidget {
   UserAddress ({super.key});

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
       final _formKey = GlobalKey<FormState>();
       UserAddressController _userAddressController=Get.put(UserAddressController());

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(        
        leading: BackButton(),
        title: Text("Your Address", style: TextStyle(fontFamily: 'assets/font/Montserrat-Regular.ttf', fontSize: 20,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              _sectionTitle("Enter Your Address",),
              _buildTextField("Email Address"),
              _buildTextField("Mobile Number"),
              _buildTextField("Enter Your Address"),
              _buildTextField("city"),
              _buildTextField("State"),
              _buildTextField("Country"),
              _buildTextField("PinCode"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text("Save", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label,) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}



















































































































// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:pro1/3rd%20day/product_detail_page.dart';
// import 'package:pro1/Task/Home_/ProductSliders/Controller/getX_Controller.dart';
// import 'package:pro1/Task/Home_/ProductSliders/Model/Product_model.dart';
// import 'package:pro1/Task/Pages/ProDetails_page.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:get/get.dart';

// class Search_page extends StatefulWidget {
//   const Search_page({super.key});

//   @override
//   State<Search_page> createState() => _Search_pageState();
// }

// class _Search_pageState extends State<Search_page> {
//   final ProductController productController = Get.put(ProductController());
//   TextEditingController searchController=TextEditingController();
//    final String razorPayKey = "rzp_test_xH8lHTk2JMtS8k";
//   final String razorPaySecret = "Q3XceCmcCk3ewdZf5G1mVtPM"; // Should be stored securely and used on backend

//   late Razorpay _razorpay;
  
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text("Payment Success: ${response.paymentId}"),
//       backgroundColor: Colors.green,
//     ));
//     print(response.data);
//     // Additional logic after success e.g. update UI, confirm order
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text("Payment Failed: ${response.message}"),
//       backgroundColor: Colors.red,
//     ));
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text("External Wallet Selected: ${response.walletName}"),
//       backgroundColor: Colors.orange,
//     ));
//   }

//   Future<String> _createOrder(double amount) async {
//     final String basicAuth =
//         'Basic ' + base64Encode(utf8.encode('$razorPayKey:$razorPaySecret'));

//     final Map<String, dynamic> body = {
//       "amount": (amount * 100).toInt(), // Amount in paise
//       "currency": "INR",
//       "receipt": "receipt_${DateTime.now().millisecondsSinceEpoch}",
//       "payment_capture": 1
//     };

//     final Uri url = Uri.parse('https://api.razorpay.com/v1/orders');

//     final response = await http.post(url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': basicAuth,
//         },
//         body: json.encode(body));

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       return data['id']; // order_id from Razorpay
//     } else {
//       throw Exception('Failed to create order: ${response.body}');
//     }
//   }

//   void _openCheckout(double amount, String productName, String description) async {
//     if (amount <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Invalid product amount."),
//         backgroundColor: Colors.red,
//       ));
//       return;
//     }

//     try {
//       final String orderId = await _createOrder(amount);
//       var options = {
//         'key': razorPayKey,
//         'amount': (amount * 100).toInt(), // in paise
//         'name': productName,
//         'order_id': orderId,
//         'description': description,
//         'timeout': 90,
//         'prefill': {
//           'contact': '9955236973', // Optionally, get from user profile
//           'email': 'krajan92946@gmail.com' // Optionally, get from user profile
//         },
//       };

//       _razorpay.open(options);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Error: ${e.toString()}"),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

// List<Product>search=[
   
// ];



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: 
//       SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Search
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.search, color: Colors.grey),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: TextField(
//                           controller: searchController,
//                           onChanged: (value) {
//                             print(value);
//                             setState(() {
//                               search.clear();
//                               productController.ProductItems.map((e){
//                               if(e.productName!.toLowerCase().contains(value.toLowerCase().trim())){
//                                   search.add(e);
//                               }
//                             }).toList();
//                             });
//                           },
//                           decoration: InputDecoration(
//                             hintText: "Search any Product..",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       Icon(Icons.mic, color: Colors.grey),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
            
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "All Featured",
//                       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
            
//                     Row(
//                       children: [
//                         _actionButton("Sort", Icons.swap_vert),
//                         SizedBox(width: 10),
//                         _actionButton("Filter", Icons.filter_alt),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 9),   
            
//               Obx(() {
//                 if (productController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else {
//                   return GridView.builder(
//                     // physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.all(8),
//                     itemCount:searchController.text==""? productController.ProductItems.length:search.length,
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 2,
//                       crossAxisSpacing: 0,
//                       mainAxisExtent: 350,
//                     ),
//                     itemBuilder: (context, index) {
//                       final product =searchController.text!=""?search[index]: productController.ProductItems[index];
//                       final price = product.finalPrice ?? 0.0;

//                       return InkWell(
//                         onTap: (){
//                            Get.to(ProductsDetailsPage(product: product,));
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(10),
                            
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(10),
//                                 ),
//                                 child: (product.images == null || product.images!.isEmpty)
//                                     ? Container(
//                                         color: const Color.fromRGBO(185, 52, 42, 1),
//                                         height: 120,
//                                         width: double.infinity,
//                                         child: const Center(
//                                           child: Text("Image Not Found!"),
//                                         ),
//                                       )
//                                     : Image.network(
//                                         product.images![0].fullUrl! + "/small/" + product.images![0].image!,
//                                         height: 120,
//                                         width: double.infinity,
//                                         fit: BoxFit.cover,
//                                       ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       product.productName.toString(),
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           '₹${product.productPrice.toString()}',
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 10),
//                                         Text(
//                                           '${product.productDiscount} %',
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             decoration: TextDecoration.lineThrough,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 10),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           '₹ $price',
//                                           style: const TextStyle(
//                                               color: Colors.orange,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Row(
//                                       children: [
//                                         Row(
//                                           children: List.generate(5, (starIndex) {
//                                             return const Icon(
//                                               Icons.star,
//                                               size: 18,
//                                               color: Colors.amber,
//                                             );
//                                           }),
//                                         ),
//                                         const SizedBox(width: 3),
//                                         const Text(
//                                           "5.0",
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.green,
//                                               fontWeight: FontWeight.bold),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Center(
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           if (price <= 0) {
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(const SnackBar(
//                                               content: Text("Invalid product price"),
//                                               backgroundColor: Colors.red,
//                                             ));
//                                             return;
//                                           }
//                                           _openCheckout(product.finalPrice!.toDouble(), product.productName ?? "Product", product.description ?? "");
//                                         },
//                                         child: const Text("Buy Now"),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
                         
//                         ),
//                       );
//                     },
//                   );
//                 }
//               }),


//               ],
//             ),
//           ),
            
//         )
//       ),
//     );
//   }

// }

// Widget _actionButton(String label, IconData icon) {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//     decoration: BoxDecoration(
//       color: Colors.grey.shade100,
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Row(
//       children: [
//         Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
//         SizedBox(width: 4),
//         Icon(icon, size: 18),
//       ],
//     ),
//   );
// }




