import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FadePage extends StatelessWidget {
  final _key = GlobalKey<FadeWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fade'),
      ),
      body: Center(
        child: FadeWidget(
          _key,
          child: Container(
            color: Colors.red,
            width: 100,
            height: 100,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _key.currentState.start();
          }),
    );
  }
}

class FadeWidget extends StatefulWidget {
  const FadeWidget(Key key, {this.child}) : super(key: key);

  final Widget child;
  @override
  FadeWidgetState createState() => FadeWidgetState();
}

class FadeWidgetState extends State<FadeWidget> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: animationController.value, child: widget.child);
  }

  void start() {
    animationController
      ..reset()
      ..forward();
  }
}
