
part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginActionEvent extends LoginEvent{
  final String userName;
  final String password;
  LoginActionEvent(this.userName,this.password);
}
