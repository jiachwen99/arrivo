import 'package:arrivo/application/login/login_event.dart';
import 'package:arrivo/application/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenStateInitial()) {
    on<LoginScreenOnSetUsernameEvent>(_setUsername);
    on<LoginScreenOnSetPasswordEvent>(_setPassword);
    on<LoginScreenOnLoginEvent>(_loginAction);
  }

  void _setUsername(LoginScreenOnSetUsernameEvent _, emit) {
    emit(state.copyWith(
      usernameStream: _.username,
    ));
  }

  void _setPassword(LoginScreenOnSetPasswordEvent _, emit) {
    emit(state.copyWith(
      passwordStream: _.password,
    ));
  }

  Future<void> _loginAction(LoginScreenOnLoginEvent _, emit) async {
    try {
      //print('${state.usernameStream}  ${state.passwordStream} Login Success');
      emit(state);
    } catch (e) {
      emit(
        LoginScreenError(e.toString()),
      );
    }
  }
}
