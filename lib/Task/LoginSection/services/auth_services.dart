// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:pro1/data/session_manager.dart';

// class AuthServices {
//   // signup Here
//  Future<String> createUser(
//     String name,
//     String email,
//     String mobile,
//     String dob,
//     String password,
//     String confirmPass,
//     bool terms,
//   ) async {
//     final respons = await http.post(
//       Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/user/signup"),
//       body: {
//         "username": name,
//         "email": email,
//         "mobile_number": mobile,
//         "dob": dob,
//         "terms": terms.toString(),
//         "password": password,
//         "password_confirmation":confirmPass
//       },
//     );
//   print(respons.statusCode);
//     if(respons.statusCode == 200){
//            print("Success!");
//            return "success";
//     }
//     return "Failed";
//   }


//   //login Here
//   Future<String> UserLogin(
//       String email,
//       String password,
//   )async {
//     final response=await http.post(Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/login"),
//     body: {
//       "email":email,
//       "password":password,
//     }
//     );
//     print(response.statusCode);
//     if(response.statusCode==200){
//       var data = jsonDecode(response.body.toString());
//       print(data["token"]);
//       await SessionManager.setToken(data["token"]);
//       return "success";
//     }
//     return "Failed";
//   }

// }


