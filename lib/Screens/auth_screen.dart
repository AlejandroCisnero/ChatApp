import 'package:chat_app/Widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/authentication.dart';
import '../Widgets/widgets.dart';
import '../main.dart';

import '../Widgets/loginImageClipper.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: LoginImageClipper(),
            child: Image.asset('assets/nightLoginBackGround.png'),
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(180.0),
            //     bottomRight: Radius.circular(180.0)),
          ),
          const SizedBox(height: 8),
          // Add from here
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Authentication(
              email: appState.email,
              loginState: appState.loginState,
              startLoginFlow: appState.startLoginFlow,
              verifyEmail: appState.verifyEmail,
              signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
              cancelRegistration: appState.cancelRegistration,
              registerAccount: appState.registerAccount,
              signOut: appState.signOut,
            ),
          ),
        ],
      ),
    );
  }
}
