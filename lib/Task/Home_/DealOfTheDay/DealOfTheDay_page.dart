import 'package:flutter/material.dart';
import 'package:pro2/Task/Home_/DealOfTheDay/Controller/DealController.dart';
import 'package:get/get.dart';

class DealOfTheDayProducts extends StatefulWidget {
  const DealOfTheDayProducts({super.key});

  @override
  State<DealOfTheDayProducts> createState() => _DealOfTheDayProductsState();
}

class _DealOfTheDayProductsState extends State<DealOfTheDayProducts> {
  final Dealcontroller dealcontroller = Get.put(Dealcontroller());
  int count = 0;

  @override

Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search
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

                // All Featured + Sort/Filter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Featured",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        _actionButton("Sort", Icons.swap_vert),
                        SizedBox(width: 10),
                        _actionButton("Filter", Icons.filter_alt),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          // Scrollable Product List
          Expanded(
            child: Obx(() {
              return dealcontroller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: dealcontroller.ProductItems.length,
                      itemBuilder: (context, index) {
                        final product = dealcontroller.ProductItems[index];
                        return buildProductCard(product);
                      },
                    );
            }),
          ),
        ],
      ),
    ),
  );
}

Widget buildProductCard(product) {
  return InkWell(
    onTap: (){
      // Get.to(ProductDetailPage(product: product));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10),),
            child: product.images == null || product.images!.isEmpty
                ? Container(
                    height: 200,
                    color: const Color.fromRGBO(185, 52, 42, 1),
                    child: Center(child: Text("Image Not Found!", style: TextStyle(fontSize: 16))),
                  )
                : Image.network(
                    product.images![0].fullUrl! + "/small/" + product.images![0].image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.productName.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
                SizedBox(height: 5),
                Text(product.description.toString(), style: TextStyle(color: Colors.grey, fontSize: 16)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('₹${product.productPrice}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text('${product.productDiscount} %', style: TextStyle(fontSize: 16, decoration: TextDecoration.lineThrough, color: Colors.grey)),
                    SizedBox(width: 10),
                    Text('₹ ${product.finalPrice}', style: TextStyle(color: Colors.orange, fontSize: 16)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Row(children: List.generate(5, (starIndex) => Icon(Icons.star, size: 18))),
                    SizedBox(width: 5),
                    Text("5 Star", style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: () => print("Buy Now clicked"), child: Text("Buy Now")),
                    ElevatedButton(onPressed: () => print("Add to Cart clicked"), child: Text("Add to Cart")),
                  ],
                ),
              ],
            ),
          ),
        ],
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
