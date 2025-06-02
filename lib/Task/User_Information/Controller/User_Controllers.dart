
import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro1/Task/AddToCart/Cart_page.dart';
class UserAddressController extends GetxController{
    TextEditingController  emailController=TextEditingController();
    TextEditingController mobileController=TextEditingController();
    TextEditingController AddressController=TextEditingController();
    TextEditingController cityController=TextEditingController();
    TextEditingController stateController=TextEditingController();
    TextEditingController countryController=TextEditingController();
    TextEditingController pinCodeController=TextEditingController();

    RxBool loading=false.obs;

    Future<void>UserAddress(context)async{
      loading.value=true;
      try{
        var headers={'Content-Type':'application/json'};
        var url=Uri.parse('');
        var body={''};
        print(body);
        final response=await http.post(url,body: body,);
        print(response.statusCode);
        print(response.body.toString());
        if(response.statusCode==200){
          loading.value=false;
          Get.to(AddToCart());
          Get.snackbar("Success","Address Saved");
        }
        else{
          loading.value=false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something Went Wrong"), backgroundColor: Colors.red,)
          );
        }
      }
      catch(e){
        print(e);
        loading.value=false;
      }
    }
}

