import 'package:equatable/equatable.dart';

abstract class LoginScreenEvent extends Equatable {}

class InitEvent extends LoginScreenEvent {
  InitEvent();
  @override
  List<Object?> get props => [];
}

class LoginScreenOnSetUsernameEvent extends LoginScreenEvent {
  final String username;
  LoginScreenOnSetUsernameEvent(this.username);
  @override
  List<Object?> get props => [];
}

class LoginScreenOnSetPasswordEvent extends LoginScreenEvent {
  final String password;
  LoginScreenOnSetPasswordEvent(this.password);
  @override
  List<Object?> get props => [];
}

class LoginScreenOnLoginEvent extends LoginScreenEvent {
  LoginScreenOnLoginEvent();
  @override
  List<Object?> get props => [];
}
