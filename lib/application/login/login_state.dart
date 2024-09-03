import 'package:equatable/equatable.dart';

class LoginScreenState extends Equatable {
  final String usernameStream;
  final String passwordStream;

  const LoginScreenState({
    this.usernameStream = '',
    this.passwordStream = '',
  });

  @override
  List<Object> get props => [usernameStream, passwordStream];

  LoginScreenState copyWith({
    String? usernameStream,
    String? passwordStream,
  }) {
    return LoginScreenState(
      usernameStream: usernameStream ?? this.usernameStream,
      passwordStream: passwordStream ?? this.passwordStream,
    );
  }
}

class LoginScreenStateInitial extends LoginScreenState {}

class LoginScreenStateLoading extends LoginScreenState {}

class LoginScreenOnLoginSuccessState extends LoginScreenState {
  final String message;
  const LoginScreenOnLoginSuccessState(this.message);
  @override
  List<Object> get props => [];
}

class LoginScreenError extends LoginScreenState {
  final String errMessage;
  const LoginScreenError(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}
