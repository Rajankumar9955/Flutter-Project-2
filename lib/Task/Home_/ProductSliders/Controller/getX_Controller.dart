import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pro1/Task/Home_/ProductSliders/Model/Product_model.dart';
import 'package:pro1/Task/Home_/ProductSliders/Services/ProductServices.dart';

class ProductController extends GetxController{
  List<Product> ProductItems=[];
  var isLoading =false.obs;

   @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
  void fetchProducts() async{
    try{
      isLoading.value=true;
       var response=await http.get(
      Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/products"),);
      if(response.statusCode==200){
        print(response.body.toString());
        var json=jsonDecode(response.body.toString());
        
        json["products"].map((e){
          return ProductItems.add(Product.fromJson(e));
        }).toList();
   
      isLoading.value=false;}
        }catch(e){
          isLoading.value=false;
      print(e);
    }
  }

}