import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/events/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: RaisedButton(
        child: Text('logout'),
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedOut(),
          );
        },
      ),
    );
  }
}
