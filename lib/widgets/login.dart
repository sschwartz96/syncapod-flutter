import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/providers/auth.dart';
import 'package:syncapod/providers/storage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();

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
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Form(
            autovalidate: true,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  loginText(),
                  loginError(context),
                  loginEmail(),
                  loginPassword(),
                  loginButton(
                    context,
                    'LOGIN',
                    Colors.purple.shade400,
                    Colors.blue.shade900,
                  ),
                  loginButton(
                    context,
                    'SIGN UP',
                    Colors.blue.shade900,
                    Colors.purple.shade400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginText() => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Text(
          'syncapod',
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.getFont('Quicksand').fontFamily,
            fontSize: 40.0,
          ),
        ),
      );

  Widget loginError(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    if (auth.wrongPassword)
      return Container(
        child: Text(
          'Wrong Password',
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
              color: Colors.grey.shade800,
            ),
            labelText: 'Email',
          ),
        ),
      );

  Widget loginPassword() => Container(
        constraints: BoxConstraints(maxWidth: 300.0),
        margin: EdgeInsets.only(bottom: 40),
        child: TextFormField(
          controller: passController,
          focusNode: focusPassword,
          onFieldSubmitted: (String s) {
            // TODO: submit login
          },
          obscureText: true,
          decoration: InputDecoration(
            labelStyle: TextStyle(
              color: Colors.grey.shade800,
            ),
            labelText: 'Password',
          ),
        ),
      );

  Widget loginButton(BuildContext context, String text, Color backColor,
          Color textColor) =>
      Container(
        constraints: BoxConstraints.expand(height: 100),
        color: backColor,
        child: (FlatButton(
          onPressed: () {
            // TODO: add login function
            var storage = Provider.of<Storage>(context, listen: false);
            Provider.of<Auth>(context, listen: false).authenticate(
                storage, userController.text, passController.text);
          },
          child: Text(
            text,
            style: TextStyle(
              fontFamily: GoogleFonts.getFont('Open Sans').fontFamily,
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
      );
}
