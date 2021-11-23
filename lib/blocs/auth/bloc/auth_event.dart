part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuth extends AuthEvent {
  const CheckAuth();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Check Auth';
}

class LogOut extends AuthEvent {
  const LogOut();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Log Out';
}

class Login extends AuthEvent {
  final String email;
  const Login({required this.email});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Login';
}
