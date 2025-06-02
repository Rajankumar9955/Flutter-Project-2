import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pro1/Task/LoginSection/Controller/Signup_controller.dart';
import 'package:pro1/Task/LoginSection/Login_Page.dart';
import 'package:pro1/Task/LoginSection/services/auth_services.dart';
import 'package:pro1/Task/Intro_Page/Task.dart';
import 'package:get/get.dart';

class CreateUserPage extends StatefulWidget {
  CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
RegisterationController registerationController=Get.put(RegisterationController());
bool _isObscure=false;
bool _Obscure=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16, width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Create an\naccount",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: registerationController.userController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        prefixIcon: Icon(Icons.verified_user),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter Username' : null;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: registerationController.emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter Email' : null;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: registerationController.mobileController,
                      decoration: InputDecoration(
                        hintText: "Mobile Number",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {},
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Please Enter Mobile Number'
                            : null;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: registerationController.dobController,
                      decoration: InputDecoration(
                        hintText: "DOB",
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context);
                      },
                    ),

                  SizedBox(height: 5),

                    TextFormField(
                      obscureText: _isObscure,
                      controller: registerationController.passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(onPressed: (){
                               setState(() {
                                 _isObscure=!_isObscure;
                               });
                        }, icon: Icon(_isObscure?Icons.visibility:Icons.visibility_off)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      obscureText: _Obscure,
                      controller: registerationController.confirmPassController,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  _Obscure=!_Obscure;
                                });
                        }, icon: Icon(_Obscure?Icons.visibility:Icons.visibility_off)),

                        border: OutlineInputBorder(),
                      ),
                    ),
                    //  SizedBox(height: 34,),

                    //       SizedBox(height: 8,),
                    Row(
                      children: [
                        Container(
                          child: Checkbox(
                            value: registerationController.selected,
                            onChanged: (value) {
                              setState(() {
                                registerationController.selected = value!;
                              });
                            },
                          ),
                        ),
                        Text("Please check the Box"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "By clicking the Register button, you agree to the public offer",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    // ////////////////////////////////////////////
                   Obx((){
                    return  MaterialButton(
                      onPressed: () async {
                            registerationController.UserRegistration(context);
                      },
                      minWidth: double.infinity,
                      child: registerationController.loading.value?CircularProgressIndicator():Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.red,
                      height: 50,
                      textColor: Colors.white,
                    );
                   })
                  ],
                ),

// //////////////////////////////////////////////

                SizedBox(height: 25),
                Column(
                  children: [
                    Text(
                      "- OR Continue With -",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomLogoWidget(
                      logo: "assets/googleImage.jpeg",
                      onTap: () {},
                    ),
                    CustomLogoWidget(
                      logo: "assets/applelogo.jpeg",
                      onTap: () {},
                    ),
                   CustomLogoWidget(logo: "assets/facebook.jpeg", onTap: () {
                     
                   },),
                  ],
                ),
                SizedBox(height: 35),
                Column(
                  children: [
                    InkWell(
                      child: Text(
                        "I Already have an Account : Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========================================================================

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      registerationController.dobController.text = _picked.toString().split(" ")[0];
    }
  }
}

class CustomLogoWidget extends StatelessWidget {
  final String logo;
  final VoidCallback onTap;
  const CustomLogoWidget({super.key, required this.logo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(logo)),
          border: Border.all(color: const Color.fromARGB(255, 234, 21, 21)),
          borderRadius: BorderRadius.circular(50),
        ),
        // child: Image.asset("assets/googleImage.jpeg", height: 50, width: 50, fit: BoxFit.cover),
      ),
    );
  }
}