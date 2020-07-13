import 'package:bloc_pattern/bloc/flash_number_bloc.dart';
import 'package:flutter/material.dart';

class FlashNumberProvider extends InheritedWidget {
  FlashNumberProvider({Key key, @required Widget child})
      : super(key: key, child: child);

  FlashNumberBloc get bloc => FlashNumberBloc();

  @override
  bool updateShouldNotify(_) => true;

  static FlashNumberProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FlashNumberProvider>();
}
