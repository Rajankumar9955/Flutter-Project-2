import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro2/Task/User_Information/User_Address.dart';


class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Delivery Address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
             SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Icon(Icons.location_on),
                 SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade300)],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Address :", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("Bharti Niketan LIG-140 Near Chetak Bridge"),
                        Text("Contact : 9955236973"),
                      ],
                    ),
                  ),
                ),
                 SizedBox(width: 8),
                  InkWell(
                    onTap: (){
                     Get.to(UserAddress());
                    },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade300)],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text("Shopping List", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ShoppingItemCard(
              imageUrl:'assets/women.jpeg',
              title: "Women’s Casual Wear",
              variations: ["Black", "Red"],
              rating: 4.8,
              price: 34.00,
              oldPrice: 64.00,
              discount: 33,
              quantity: 1,
            ),
             SizedBox(height: 16),
            ShoppingItemCard(
              imageUrl: 'assets/mens.webp',
              title: "Men’s Jacket",
              variations: ["Green", "Grey"],
              rating: 4.7,
              price: 45.00,
              oldPrice: 67.00,
              discount: 28,
              quantity: 1,
            ),
            SizedBox(height: 16),
            ShoppingItemCard(
              imageUrl: 'assets/kids.jpeg',
              title: "Kid’s Jacket",
              variations: ["Green","Grey"],
              rating: 4.7,
              price: 52.00,
              oldPrice: 100.00,
              discount: 48,
              quantity: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppingItemCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final List<String> variations;
  final double rating;
  final double price;
  final double oldPrice;
  final int discount;
  final int quantity;

  const ShoppingItemCard({
    required this.imageUrl,
    required this.title,
    required this.variations,
    required this.rating,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.quantity,
    super.key,
  });

  @override
  State<ShoppingItemCard> createState() => _ShoppingItemCardState();
}



class _ShoppingItemCardState extends State<ShoppingItemCard> {
  int qnty=1;
  @override
  Widget build(BuildContext context) {
    final quantity=qnty;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade200)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(widget.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("Variations: ${widget.variations.join(', ')}"),
                    Row(
                      children: [
                        Text(widget.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text("\₹${widget.price}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(width: 8),
                        Text("\₹${widget.oldPrice}",
                            style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                        const SizedBox(width: 8),
                        Text("upto ${widget.discount}% off", style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
           Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Order ($quantity) :",),
              Text("\₹${(widget.price * quantity).toStringAsFixed(2)}",
                  style:  TextStyle(fontWeight: FontWeight.bold)),
                  ElevatedButton(onPressed: (){
                       setState(() {
                        if(qnty<5){
                           qnty++;
                        }
                         else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("You can Add Only 5 Products"), backgroundColor: Colors.red),
                                 );
                         }
                       });
                  }, child: Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  ElevatedButton(onPressed: (){
                           setState(() {
                          if(qnty>1){
                            qnty--;
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No possible Decrement"), backgroundColor: Colors.red),
                                 );
                          }
                       });
                  }, child: Text("-",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
            ],
          ),
        ],
      ),
    );
  }
}
