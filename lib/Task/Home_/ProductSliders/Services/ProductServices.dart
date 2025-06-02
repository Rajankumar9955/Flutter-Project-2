


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pro1/Task/Home_/ProductSliders/Model/Product_model.dart';


class RemoteServices{
  static var client=http.Client();
   Future<List<Product>>fetchProducts() async{
    var response=await client.get(
      Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/products"),);
      if(response.statusCode==200){
        print(response.body.toString());
        var json=jsonDecode(response.body.toString());
        List<Product> data = [];
        json["products"].map((e){
          return data.add(Product.fromJson(e));
        }).toList();
        return data;
      }
      else
      {
        print('Error response: ${response.body}');
      }
      return [];
  }
}