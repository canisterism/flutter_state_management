import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/bloc/login_bloc.dart';
import 'package:bloc_login/repositories/user_repository.dart';
import 'package:bloc_login/widagets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login Page')),
        body: BlocProvider(
            create: (context) {
              return LoginBloc(
                  userRepository: userRepository,
                  authenticationBloc:
                      BlocProvider.of<AuthenticationBloc>(context));
            },
            child: LoginForm()));
  }
}
