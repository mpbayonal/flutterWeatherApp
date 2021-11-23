import 'dart:async';
import 'package:logysto_app/blocs/auth/resources/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is Login) {
      yield* _login(event);
    } else if (event is CheckAuth) {
      yield* _checkAuth(event);
    } else if (event is LogOut) {
      yield* _logOut(event);
    }
  }

  Stream<AuthState> _login(Login event) async* {
    try {
      dynamic response = await _authRepository.logIn(email: event.email);

      yield AuthInitial();
    } on Exception {
      yield AuthInitial();
    }
  }

  Stream<AuthState> _logOut(LogOut event) async* {
    try {
      print("object");
      await _authRepository.logOut();
      bool response = await _authRepository.checkAuth();
      if (response) {
        yield AuthAuthenticated();
      } else {
        yield AuthunAuthenticated();
      }
    } on Exception {
      print("object");
      yield AuthInitial();
    }
  }

  Stream<AuthState> _checkAuth(CheckAuth event) async* {
    try {
      bool response = await _authRepository.checkAuth();
      if (response) {
        yield AuthAuthenticated();
      } else {
        yield AuthunAuthenticated();
      }
    } on Exception catch (e) {
      yield AuthunAuthenticated();
    }
  }
}
