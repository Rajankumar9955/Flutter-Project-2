import 'package:flutter/material.dart';
import 'package:pro1/Task/Home_/ProductSliders/Model/Product_model.dart';


class ProductsDetailsPage extends StatelessWidget {
  final Product product ;
  const ProductsDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: Text(""),),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 254, 253, 253))),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 254, 254, 253),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(255, 224,167,1730),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                                
                              )
                            ]
                          ),
                          child: Column(children: [
                          product.images!.isEmpty ||product.images==null ? 
                          Container(
                            child: Center( child: Text("Image Not Found!"),),
                            color: const Color.fromRGBO(185, 52, 42, 1,),height: 200,width: double.infinity,)
                           :Image.network(
                            product.images![0].fullUrl! +
                                "/small/" +
                                product.images![0].image!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                             Text(product.productName.toString(),
                        style: TextStyle(fontSize: 30, color: Colors.red),
                  ),
                Text( "₹ ${product.productPrice.toString()}",
                        style: TextStyle(fontSize: 30, color: const Color.fromARGB(255, 16, 241, 68)),
                ),
                
                  Text(product.description.toString()
                   , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  )
 
                          ],),
                        
                  ),
                               ],
              ),
            ),
          ),
    );
  }
}