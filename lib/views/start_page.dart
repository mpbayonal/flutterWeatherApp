import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logysto_app/blocs/auth/bloc/auth_bloc.dart';
import 'package:logysto_app/widgets/spacing_container.dart';

import 'package:provider/provider.dart';

import '../constants.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const StartPage());
  }

  @override
  State<StartPage> createState() => _MyStartPageState();
}

class _MyStartPageState extends State<StartPage> {
  late bool _passwordVisible;
  final emailController = TextEditingController();
  bool userEmailValidate = false;
  final passwordController = TextEditingController();
  bool userPasswordValidate = false;

  bool sending = false;

  void initState() {
    _passwordVisible = false;
  }

  bool validateEmailField(String userInput) {
    if (userInput.isEmpty || !userInput.contains("@")) {
      setState(() {
        userEmailValidate = true;
      });
      return false;
    }
    setState(() {
      userEmailValidate = false;
    });
    return true;
  }

  bool validatePasswordField(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        userPasswordValidate = true;
      });
      return false;
    }
    setState(() {
      userPasswordValidate = false;
    });
    return true;
  }

  void _editLoading(bool stateSending) async {
    if (sending != stateSending) {
      setState(() {
        sending = stateSending;
      });
    }
  }

  void _action() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: surfaceBckG,
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 0, left: 50, right: 50),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SpacingContainer(),
                      const SpacingContainer(),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0, left: 10, right: 10),
                          child: Text('Email',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: titulosinternos)),
                        ),
                      ),
                      const SpacingContainer(),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: emailController,
                        onTap: () {
                          setState(() {
                            userEmailValidate = false;
                          });
                        },
                        onChanged: (text) {
                          setState(() {
                            userEmailValidate = false;
                          });
                        },
                        style:
                            const TextStyle(fontSize: 18.0, color: textoInfo),
                        //This will obscure text dynamically
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.all(12),
                            border: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide(color: textosInfinput)
                                //borderSide: const BorderSide(),
                                ),
                            disabledBorder: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide(color: textosInfinput)
                                //borderSide: const BorderSide(),
                                ),
                            enabledBorder: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide(color: textosInfinput)
                                //borderSide: const BorderSide(),
                                ),
                            focusedBorder: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide(color: textosInfinput)
                                //borderSide: const BorderSide(),
                                ),
                            hintStyle: TextStyle(
                                fontSize: 18.0, color: textosInfinput),
                            hintText: 'Enter your email',
                            errorText:
                                userEmailValidate ? "Email is not valid" : null

                            // Here is key idea
                            ),
                      ),
                      const SpacingContainer(),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0, left: 10, right: 10),
                          child: Text('Password',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: titulosinternos)),
                        ),
                      ),
                      const SpacingContainer(),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        onTap: () {
                          setState(() {
                            userPasswordValidate = false;
                          });
                        },
                        onChanged: (text) {
                          setState(() {
                            userPasswordValidate = false;
                          });
                        },
                        obscureText: !_passwordVisible,
                        style:
                            const TextStyle(fontSize: 18.0, color: textoInfo),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true, // Added this
                          contentPadding: const EdgeInsets.all(12),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: textosInfinput),
                            borderRadius: BorderRadius.circular(90.7),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: textosInfinput),
                            borderRadius: BorderRadius.circular(90.7),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: textosInfinput),
                            borderRadius: BorderRadius.circular(90.7),
                          ),
                          border: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide(color: textosInfinput)
                              //borderSide: const BorderSide(),
                              ),

                          hintText: 'Enter your password',
                          errorText: userPasswordValidate
                              ? "Password is not valid, it must contain minimum 1 Upper case, minimum 1 lowercase, minimum 1 numeric number, minimum 1 special character"
                              : null,
                          hintStyle: const TextStyle(
                              fontSize: 18.0, color: textosInfinput),

                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: textoInfo,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SpacingContainer(),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                            child: sending
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : const Text("Log In",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(primary),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                        side:
                                            const BorderSide(color: primary)))),
                            onPressed: () {
                              validateEmailField(emailController.text);
                              validatePasswordField(passwordController.text);
                              if (!userEmailValidate && !userPasswordValidate) {
                                _editLoading(true);
                                BlocProvider.of<AuthBloc>(context)
                                    .add(Login(email: emailController.text));
                              }
                            }),
                      ),
                      const SpacingContainer(),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
