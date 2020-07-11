import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InheritedPage extends StatefulWidget {
  @override
  _InheritedPageState createState() => _InheritedPageState();
}

class _InheritedPageState extends State<InheritedPage> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('inherited')),
      body: Center(
        child: TimeInherited(
          time: DateTime.now().toString(),
          // you can declare 'const' widget which can follow changes
          // by Wrapping child with widget extending InheritedWidget.
          child: const NonsenseWidget(),
        ),
      ),
    );
  }
}

class TimeInherited extends InheritedWidget {
  const TimeInherited({
    Key key,
    @required this.time,
    @required Widget child,
  }) : super(key: key, child: child);
  final String time;

  // can access to TimeInherited in O(1).
  static TimeInherited of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TimeInherited>();

  // Notify Update to widget depending on this widget
  @override
  bool updateShouldNotify(TimeInherited old) {
    return old.time != time;
  }
}

class NonsenseWidget extends StatelessWidget {
  const NonsenseWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(TimeInherited.of(context).time.toString()),
    );
  }
}
