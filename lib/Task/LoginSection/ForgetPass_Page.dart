
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pro1/Task/LoginSection/CreateUser_page.dart';
import 'package:pro1/Task/LoginSection/ForgetPass_Page.dart';
import 'package:pro1/Task/Intro_Page/Task.dart';

class ForgetpassPage extends StatelessWidget {
  const ForgetpassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 16,width: 18,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Forget\npassword?",
                      style: TextStyle(
                        fontSize: 30, color: Colors.black,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                      
                    ),
                    SizedBox(height: 34,),
                    TextFormField(
                     decoration: InputDecoration(
                      hintText: "Enter your Email Address",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      
                     ),
                     onChanged: (String value){
                            
                     },
                     validator: (value) {
                       return value!.isEmpty ? 'Please Enter Username or Email' : null;
                     },
                     
                    ),
                    SizedBox(height: 28,),
                    Text("* We will send you a message to set or reset your new password"),
                     SizedBox(height: 35,),
                    MaterialButton(onPressed: (){},
                    minWidth: double.infinity,
                         child: Text("Submit",style: TextStyle(fontSize: 15, fontFamily: "Montserrat", fontWeight: FontWeight.bold),),
                         color: Colors.red,
                         height: 50,
                         textColor: Colors.white,
                    ),
                  ],
              ),  
            ],
          ),
        ),
        ) ,
    );
  }
}