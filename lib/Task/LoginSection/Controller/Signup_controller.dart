import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro1/Task/LoginSection/CreateUser_page.dart';
import 'package:pro1/Task/LoginSection/Login_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterationController extends GetxController {
  TextEditingController userController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController dobController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  bool selected = false;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

 
  RxBool loading=false.obs;

  Future<void> UserRegistration(context) async {
     loading.value=true;
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
        "https://phplaravel-1264682-5431883.cloudwaysapps.com/api/user/signup",
      );
      var body = {
        "username": userController.text,
        "email": emailController.text,
        "mobile_number": mobileController.text,
        "dob": dobController.text,
        "terms": selected.toString(),
        "password": passwordController.text,
        "password_confirmation": confirmPassController.text,
      };
      print(body);
      final response = await http.post(
        url,
        body: body,
        // headers: headers,
      );
      print(response.statusCode);
      print(response.body.toString());
      if (response.statusCode == 200) {
        loading.value=false;
        Get.offAll(LoginPage());
        Get.snackbar("Success", "Account create success");
      }
      else {
        // Login failed
        loading.value=false;
          if (response.statusCode != 200) {
            final responseData = json.decode(response.body);
          
            if (responseData['status'] == 'error') {
              final errorList = responseData['errors'];

              String errorMessage = '';
              if (errorList['email'] != null && errorList['email'].isNotEmpty) {
                errorMessage = errorList['email'][0];
              } else {
                if (errorList['terms'] != null && errorList['terms'].isNotEmpty) {
                errorMessage = errorList['terms'][0];
              }
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
              );
            }
          }
      }
    } catch (e) {
      loading.value=false;
      print(e.toString());
      // Get.to(CreateUserPage());
      Get.snackbar("Error", e.toString());
      Get.snackbar('Error', e.toString());
      print(e.toString());
    }
  }
}
