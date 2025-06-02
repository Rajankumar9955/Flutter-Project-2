
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pro2/Task/Category/Model/Cotegories_Model.dart';


class CategoriesController extends GetxController{
  List<CategoriesModel> Categories=[];
  var isLoading =false.obs;

   @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }
  void fetchCategories() async{
    try{
      isLoading.value=true;
       var response=await http.get(
      Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/categories"),);
      if(response.statusCode==200){
        print(response.body.toString());
        var json=jsonDecode(response.body.toString());
        
        json["categories"].map((e){
          return Categories.add(CategoriesModel.fromJson(e));
        }).toList();
   
      isLoading.value=false;}
        }catch(e){
          isLoading.value=false;
      print(e);
    }
  }

}