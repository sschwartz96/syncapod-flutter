import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/providers/auth.dart';
import 'package:syncapod/providers/storage.dart';

enum LoginPageState { IDLE, AUTHENTICATING, WRONG }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  LoginPageState _state = LoginPageState.IDLE;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // made so that we can unfocus if we tap outside a textfield
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                autovalidate: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _loginLogo(),
                    SizedBox(height: 40),
                    //_loginText(context),
                    loginError(context),
                    loginEmail(),
                    SizedBox(height: 10),
                    loginPassword(context),
                    SizedBox(height: 6),
                    ForgotPasswordText(),
                    SizedBox(height: 30),
                    loginButton(context),
                    SizedBox(height: 120),
                    signupButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginLogo() => Container(
        child: Image.asset(
          'assets/images/syncapod_logo.png',
          alignment: Alignment.center,
          fit: BoxFit.fill,
          width: 200,
          height: 200,
        ),
      );

  Widget _loginText(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Text(
          'Please sign in to continue',
          style: Theme.of(context).textTheme.headline6,
        ),
      );

  Widget loginError(BuildContext context) {
    if (_state == LoginPageState.WRONG)
      return Container(
        child: Text(
          'Wrong username or password',
          style: TextStyle(color: Colors.red),
        ),
      );
    return Container();
  }

  Widget loginEmail() => Container(
        constraints: BoxConstraints(maxWidth: 300.0),
        margin: EdgeInsets.only(bottom: 20, top: 20),
        child: TextFormField(
          controller: userController,
          focusNode: focusEmail,
          onFieldSubmitted: (String s) {
            focusPassword.requestFocus();
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
            labelText: 'Email',
          ),
        ),
      );

  Widget loginPassword(BuildContext context) => Container(
        constraints: BoxConstraints(maxWidth: 300.0),
        child: TextFormField(
          controller: passController,
          focusNode: focusPassword,
          onFieldSubmitted: (String s) {
            _authenticate(context);
          },
          obscureText: true,
          decoration: InputDecoration(
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
            labelText: 'Password',
          ),
        ),
      );

  Widget signupButton(BuildContext context) => FlatButton(
        textColor: Colors.grey,
        onPressed: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Sign Up',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .apply(color: Colors.grey, fontSizeDelta: 8.0),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(Icons.person_add),
          ],
        ),
      );
  //  FlatButton(
  //   color: Colors.grey.shade700,
  //   onPressed: () {},
  //   child: Container(
  //     width: 140,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Text(
  //           'Sign Up',
  //           style: Theme.of(context)
  //               .textTheme
  //               .bodyText1
  //               .apply(fontSizeDelta: 8.0),
  //         ),
  //         SizedBox(
  //           width: 8,
  //         ),
  //         Icon(Icons.person_add)
  //       ],
  //     ),
  //   ),
  // );

  Widget loginButton(BuildContext context) => FlatButton(
        color: Theme.of(context).buttonColor,
        onPressed: () {
          _authenticate(context);
        },
        child: Container(
          width: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Login',
                style: Theme.of(context).textTheme.button,
              ),
              SizedBox(
                width: 8,
              ),
              Icon(Icons.forward)
            ],
          ),
        ),
      );

  void _authenticate(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final storage = Provider.of<StorageProvider>(context, listen: false);
    _state = LoginPageState.AUTHENTICATING;
    // show a loading dialog
    showDialog(
      context: context,
      builder: (context) => FutureBuilder(
        future: authProvider.authenticate(
            storage, userController.text, passController.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if the username or password is wrong
            if (!snapshot.data) _state = LoginPageState.WRONG;
            // else means its correct and handled by AuthProvider

            Navigator.maybePop(context);
            return Container();
          } else {
            return Center(
              child: Container(
                  height: 50, width: 50, child: CircularProgressIndicator()),
            );
          }
        },
      ),
    ).whenComplete(() => setState(() {}));
  }
}

class ForgotPasswordText extends StatefulWidget {
  @override
  _ForgotPasswordTextState createState() => _ForgotPasswordTextState();
}

class _ForgotPasswordTextState extends State<ForgotPasswordText> {
  Color _textColor = Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: _textColor,
          fontSize: 20,
          fontWeight: FontWeight.w300,
          decoration: TextDecoration.underline,
          decorationColor: Colors.grey.shade600,
        ),
      ),
    );
  }
}
