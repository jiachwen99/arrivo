import 'package:arrivo/domain/configure/colors.dart';
import 'package:arrivo/domain/configure/dimens.dart';
import 'package:arrivo/application/login/login_bloc.dart';
import 'package:arrivo/application/login/login_event.dart';
import 'package:arrivo/application/login/login_state.dart';
import 'package:arrivo/domain/configure/theme.dart';
import 'package:arrivo/infrastructure/system/validation_helper.dart';
import 'package:arrivo/presentation/widget/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginScreenBloc>(
        create: (_) => LoginScreenBloc(),
        child: Container(
          color: ColorConfig.blueSub3,
          width: DimenConfig.getScreenWidth(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: DimenConfig.getScreenWidth(percent: 35),
                padding: EdgeInsets.symmetric(
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: ThemeService.defaultBoxShadow
                ),
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      _buildLoginLabel(),
                      SizedBox(
                        height: 24,
                      ),
                      _buildUsernameTextField(),
                      SizedBox(
                        height: 24,
                      ),
                      _buildPasswordTextField(),
                      SizedBox(
                        height: 24,
                      ),
                      _buildButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildLoginLabel() => Text(
        'User Login',
        style: ThemeService.boldTextStyle(
          fontSize: 14,
        ),
      );

  Widget _buildUsernameTextField() => BlocBuilder<LoginScreenBloc, LoginScreenState>(builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                style: ThemeService.regularTextStyle(),
                decoration: ThemeService.grabTextFieldDecoration("Username", prefixIcon: Icon(Icons.person, color: Theme.of(context).colorScheme.secondary), showPrefix: true),
                onChanged: (String value){
                  BlocProvider.of<LoginScreenBloc>(context).add(LoginScreenOnSetUsernameEvent(value));
                  setState(() {});
                },
                validator: (value){
                  return ValidationHelper.validateNotEmpty(value.toString(), "Username");
                },
              ),
              
            ],
          ),
        );
      });

  Widget _buildPasswordTextField() => BlocBuilder<LoginScreenBloc, LoginScreenState>(builder: (context, state) {
        return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  style: ThemeService.regularTextStyle(),
                  decoration: ThemeService.grabTextFieldDecoration("Password", prefixIcon: Icon(Icons.lock, color: Theme.of(context).colorScheme.secondary), showPrefix: true),
                  onChanged: (String value){
                    BlocProvider.of<LoginScreenBloc>(context).add(LoginScreenOnSetPasswordEvent(value));
                    setState(() {});
                  },
                  validator: (value){
                    return ValidationHelper.validateNotEmpty(value.toString(), "Password");
                  },
                ),
              ],
            ));
      });

  Widget _buildButton() => BlocBuilder<LoginScreenBloc, LoginScreenState>(builder: (context, state) {
        return Container(
          child: ThemeButton(
            text: 'Login',
            onPressed: () {
              BlocProvider.of<LoginScreenBloc>(context).add(LoginScreenOnLoginEvent());
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            },
            enable: _passwordController.text.isNotEmpty && _usernameController.text.isNotEmpty,
          ),
        );
      });
}
