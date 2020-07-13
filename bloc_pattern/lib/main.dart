import 'package:flutter/material.dart';
import 'package:bloc_pattern/screens/flash_number_screen.dart';
import 'package:bloc_pattern/bloc/flash_number_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FlashNumberProvider(
        child: MyHomePage(title: 'Bloc Example'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('FlashNumber'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (c) => FlashNumberScreen())),
            )
          ],
        ),
      ),
    );
  }
}
