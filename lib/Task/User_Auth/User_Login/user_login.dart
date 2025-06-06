// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/Task/App_First_Screen/app_first_screen.dart';
import 'package:pro2/Task/User_Auth/Bloc/user_bloc.dart';
import 'package:pro2/Task/User_Auth/User_Forget_password/Forget_password.dart';
import 'package:pro2/Task/User_Auth/User_Signup/user_signup.dart';
import 'package:pro2/Task/checkup.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _formKey = GlobalKey<FormState>();
  final LoginBloc loginBloc = LoginBloc();

  bool _isObscure = true;

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(

            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Center(child: Text(state.message))));
                }
                if(
                  state is LoginSuccessState
                ){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AppFirstScreen(),), (route) => true,);
                }
              },
              bloc: loginBloc,
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(height: 16, width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome\nBack!",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 34),
                        TextFormField(
                          // controller: loginController.emailController,
                          controller: userController,
                          decoration: InputDecoration(
                            hintText: "User Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter UserEmail';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 28),
                        TextFormField(
                          obscureText: _isObscure,
                          // controller: loginController.passwordController,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8),
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetpassPage(),));
                            },
                          ),
                        ),
                        SizedBox(height: 25),

                        state is LoginLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : MaterialButton(
                              onPressed: () async {
                                loginBloc.add(
                                  LoginActionEvent(
                                    userController.text,
                                    passwordController.text,
                                  ),
                                );
                              },
                              minWidth: double.infinity,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: Colors.red,
                              height: 50,
                              textColor: Colors.white,
                            ),
                      ],
                    ),
                    SizedBox(height: 45),
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
                    SizedBox(height: 24),

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
                        CustomLogoWidget(
                          logo: "assets/facebook.jpeg",
                          onTap: () {},
                        ),
                      ],
                    ),

                    SizedBox(height: 35),
                    Column(
                      children: [
                        InkWell(
                          child: Text(
                            "Create An Account: Signup",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSignPage()));
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
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
      ),
    );
  }
}