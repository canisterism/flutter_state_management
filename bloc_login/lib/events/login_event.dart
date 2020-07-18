import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({
    @required this.username,
    @required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}
