import 'package:flutter/material.dart';
import 'package:set_state/screens/clock_page.dart';
import 'package:set_state/screens/fade.dart';
import 'package:set_state/screens/inherited.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'setState',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ClockPage()));
                },
                child: Text('clock', style: TextStyle(color: Colors.white))),
            MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FadePage()));
                },
                child: Text('fade', style: TextStyle(color: Colors.white))),
            MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InheritedPage()));
                },
                child: Text('inherited', style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
