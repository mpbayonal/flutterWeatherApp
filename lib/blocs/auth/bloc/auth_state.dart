part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated() : super();
}

class AuthunAuthenticated extends AuthState {
  const AuthunAuthenticated() : super();
}
