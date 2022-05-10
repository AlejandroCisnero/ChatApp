import 'package:chat_app/Providers/darkThemeProvider.dart';
import 'package:chat_app/Widgets/loginImageClipper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/authentication.dart';
import '../Providers/applicationState.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const route = '/';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    var darkThemeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipPath(
                clipper: LoginImageClipper(),
                child: AnimatedCrossFade(
                  firstChild: Image.asset('assets/nightLoginBackGround.png'),
                  secondChild: Image.asset('assets/dayLoginBackGround.jpg'),
                  crossFadeState: !darkThemeProvider.darkTheme
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 1000),
                ),
              ),
              // Add from here
              Expanded(
                child: Consumer<ApplicationState>(
                  builder: (context, appState, _) => Authentication(
                    email: appState.email,
                    loginState: appState.loginState,
                    startLoginFlow: appState.startLoginFlow,
                    verifyEmail: appState.verifyEmail,
                    signInWithEmailAndPassword:
                        appState.signInWithEmailAndPassword,
                    cancelRegistration: appState.cancelRegistration,
                    registerAccount: appState.registerAccount,
                    signOut: appState.signOut,
                    user: appState.user,
                  ),
                ),
              ),
              // to here
              IconButton(
                icon: const Icon(Icons.light_mode),
                onPressed: () async {
                  await darkThemeProvider.darkThemePreference.getThemeMode() !=
                          true
                      ? setState(() {
                          darkThemeProvider.darkTheme = true;
                        })
                      : setState(() {
                          darkThemeProvider.darkTheme = false;
                        });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
