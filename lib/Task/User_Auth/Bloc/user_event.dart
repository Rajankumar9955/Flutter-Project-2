
part of 'user_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginActionEvent extends LoginEvent{
  final String userName;
  final String password;
  LoginActionEvent(this.userName,this.password);
}


// Signup 
@immutable
abstract class SignUpEvent{}
class SignUpActionEvent extends SignUpEvent{
  final String username;
  final String email;
  final String mobile;
  final String dob;
  final String password;
  final String confirmPass;
  final bool selected;
  SignUpActionEvent(this.username, this.email, this.mobile,  this.dob,  this.password, this.confirmPass, this.selected);
}