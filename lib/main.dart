import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logysto_app/views/home_page.dart';
import 'package:logysto_app/views/start_page.dart';
import 'package:provider/provider.dart';
import 'blocs/auth/bloc/auth_bloc.dart';
import 'blocs/weather/bloc/weather_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<WeatherBloc>(
          create: (BuildContext context) => WeatherBloc(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(const CheckAuth());
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              _navigator.pushAndRemoveUntil<void>(
                HomePage.route(),
                (route) => false,
              );
            }
            if (state is AuthunAuthenticated) {
              _navigator.pushAndRemoveUntil<void>(
                StartPage.route(),
                (route) => false,
              );
            } else {
              BlocProvider.of<AuthBloc>(context).add(const CheckAuth());
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => StartPage.route(),
    );
  }
}
