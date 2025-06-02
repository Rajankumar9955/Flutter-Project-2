import 'package:pro1/Task/LoginSection/Login_Page.dart';
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
                prefs?.clear();
                Get.offAll(LoginPage());
   }
}
