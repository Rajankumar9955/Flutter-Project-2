


import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pdf/widgets.dart';
import 'package:pro2/Task/Intro_Page/Task.dart';
import 'package:pro2/data/session_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc <LoginEvent, LoginState> {
  LoginBloc(): super(LoginInitialState()){
   on<LoginActionEvent>(getLogin);
  }

  FutureOr<void> getLogin(LoginActionEvent event, Emitter<LoginState> emit) async{
   try{
    emit(LoginLoadingState());
      var headers= {'Content-Type': 'application/json'};
      var url=Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/login");
    Map body={
        "email": event.userName,
        "password": event.password,
    };
        http.Response response=await http.post(url,body:body,);
        print(response.statusCode);
        print(response.body);
         var data = jsonDecode(response.body);
        if(response.statusCode==200){
          SessionManager.setToken(data["token"]);
          emit(LoginSuccessState(message: data['message']));
        } else{
                  emit(LoginError(message: data['message']));
          }
    }catch(e){
      emit(LoginError(message: e.toString()));
     print(e.toString());
    }
  }
  }

// Signup

class SignUpBloc extends Bloc <SignUpEvent, SignUpState> {
  SignUpBloc(): super(SignUpInitialState()){
   on<SignUpActionEvent>(getSignUp);
  }

  bool selected = false;

FutureOr<void> getSignUp(SignUpActionEvent event, Emitter<SignUpState> emit) async{
   try{
      emit(SignUpLoadingState());
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
        "https://phplaravel-1264682-5431883.cloudwaysapps.com/api/user/signup",
      );

    Map body={
        "username": event.username,
        "email": event.email,
        "mobile_number": event.mobile,
        "dob": event.dob,
        "terms": selected.toString(),
        "password": event.password,
        "password_confirmation": event.confirmPass,
    };
        http.Response response=await http.post(url,body:body,);
        print(response.statusCode);
        print(response.body);
         var data = jsonDecode(response.body);
        if(response.statusCode==200){
          emit(SignUpSucessState(message: data['message']));
        } else{
                emit(SignUpError(message: data['message']));
          }
    }catch(e){
      emit(SignUpError(message: e.toString()));
     print(e.toString());
    }
  }

 }
