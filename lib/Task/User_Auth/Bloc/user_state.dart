
part of 'user_bloc.dart';



@immutable
abstract class LoginState{}

class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}


class LoginSuccessState extends LoginState{
  final String message;
  LoginSuccessState({required this.message});

}

class LoginError extends LoginState{
    final String message;
    LoginError({required this.message});
}


// signup
   @immutable
   abstract class SignUpState{}
   class SignUpInitialState extends SignUpState{}

   class SignUpLoadingState extends SignUpState{}

   class SignUpSucessState extends SignUpState{
    final String message;
    SignUpSucessState({required this.message});
   }

   class SignUpError extends SignUpState{
     final String message;
     SignUpError({required this.message});
   }
/*

ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                             content: Text("Your are print Your purchase items invoice"),
                             backgroundColor: Colors.red,
                        ),
 */