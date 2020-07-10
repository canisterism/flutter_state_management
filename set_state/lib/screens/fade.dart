import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FadePage extends StatefulWidget {
  @override
  _FadePageState createState() => _FadePageState();
}

class _FadePageState extends State<FadePage> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fade'),
      ),
      body: Center(
          child: Opacity(
        opacity: animationController.value,
        child: Container(
          color: Colors.red,
          width: 100,
          height: 100,
        ),
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            animationController
              ..reset()
              ..forward();
          }),
    );
  }
}
