import 'package:chat_app/Widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/authentication.dart';
import '../Widgets/widgets.dart';
import '../main.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ClipRRect(
            child: Image.asset('assets/nightLoginBackGround.png'),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(180.0),
                bottomRight: Radius.circular(180.0)),
          ),
          const SizedBox(height: 8),
          IconAndDetail(Icons.calendar_today, 'October 30',
              Theme.of(context).colorScheme.onPrimary),
          IconAndDetail(Icons.location_city, 'San Francisco',
              Theme.of(context).colorScheme.onPrimary),
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
          // to here
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("What we'll be doing"),
          const Paragraph(
            'Join us for a day full of Firebase Workshops and Sushi!',
          ),
        ],
      ),
    );
  }
}
