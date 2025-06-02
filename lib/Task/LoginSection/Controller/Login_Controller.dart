 import 'dart:convert';
import 'package:get/get.dart';
 import 'package:flutter/material.dart';
 import 'package:http/http.dart' as http;
import 'package:pro1/Task/Home_/Home_content/HomeContent_page.dart';
import 'package:pro1/Task/Home_/Home_page.dart';
import 'package:pro1/Task/LoginSection/CreateUser_page.dart';
import 'package:pro1/Task/LoginSection/Login_Page.dart';
import 'package:pro1/data/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{



  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

   
   RxBool loading=false.obs;

  Future<void>userLogin(context)async{
    loading.value=true;
    try{
      var headers= {'Content-Type': 'application/json'};
      var url=Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/login");
    Map body={
   
        "email": emailController.text,
        "password": passwordController.text,
    };
        http.Response response=await http.post(url,body:body,);
        print(response.statusCode);
        print(response.body);
        if(response.statusCode==200){
          loading.value=false;
          var data = jsonDecode(response.body);
          SessionManager.setToken(data["token"]);
            emailController.clear();
            passwordController.clear();
            Get.off(TaskHomePage());
            Get.snackbar("success ", data["message"]);
          } 
          else {
              // Login failed
              loading.value=false;
                final errorData = json.decode(response.body);
                String errorMessage = errorData['message'] ?? 'Login failed';
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                   content: Text(errorMessage),
                      backgroundColor: Colors.red,
      ),
            );
          }
    }catch(e){
      loading.value=false;
     print(e.toString());
    }
  }
}