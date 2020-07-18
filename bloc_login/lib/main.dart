import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/events/authentication_event.dart';
import 'package:bloc_login/pages/home_page.dart';
import 'package:bloc_login/pages/login_page.dart';
import 'package:bloc_login/pages/splash_page.dart';
import 'package:bloc_login/repositories/user_repository.dart';
import 'package:bloc_login/states/authentication_state.dart';
import 'package:bloc_login/utils/simple_bloc_observer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  EquatableConfig.stringify = true;
  Bloc.observer = SimpleBlocObserver();
  final userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
      create: (_) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted());
      },
      child: App(userRepository: userRepository)));
}

class App extends StatelessWidget {
  const App({Key key, @required this.userRepository}) : super(key: key);
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case AuthenticationInitial:
              return SplashPage();
              break;
            case AuthenticationSuccess:
              return HomePage();
              break;
            case AuthenticationFailure:
              return LoginPage(userRepository: userRepository);
              break;
            case AuthenticationInProgress:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              return LoginPage(userRepository: userRepository);
              break;
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
