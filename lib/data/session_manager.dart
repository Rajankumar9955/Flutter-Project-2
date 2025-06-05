
import 'package:flutter/material.dart';
import 'package:pro2/Task/User_Auth/User_Login/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

 final Future<SharedPreferences>_prefs=SharedPreferences.getInstance();

class SessionManager {
  static SharedPreferences? preference;
  static String token ="token";

  Future<void> init() async {
    preference = await SharedPreferences.getInstance();
  }
 static dynamic setToken(String _token){
   return preference!.setString(token, _token);
  }
static dynamic  getToken(){
    return preference!.getString(token);
  }

   static logOut()async{
           SharedPreferences? prefs=await _prefs;
                prefs.clear();
                Get.offAll(LoginPage());
                // Navigator.pop(context, MaterialPageRoute(builder: (context)=>LoginPage()));
   }
}
