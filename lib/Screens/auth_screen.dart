import 'package:chat_app/Providers/darkThemeProvider.dart';
import 'package:chat_app/Widgets/loginImageClipper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/authentication.dart';
import '../Providers/applicationState.dart';
import '../Widgets/user_image_picker.dart';

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
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            ClipPath(
              clipper: LoginImageClipper(),
              child: Stack(children: [
                AnimatedCrossFade(
                  firstChild: Image.asset('assets/nightLoginBackGround.png'),
                  secondChild: Image.asset('assets/dayLoginBackGround.jpg'),
                  crossFadeState: !darkThemeProvider.darkTheme
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 1000),
                ),
                Positioned(
                    top: 40,
                    left: (MediaQuery.of(context).size.width / 2) - 55,
                    child: Provider.of<ApplicationState>(context).loginState ==
                            ApplicationLoginState.register
                        ? UserImagePicker(Provider.of<ApplicationState>(context,
                                listen: false)
                            .setUserImage)
                        : Container()),
              ]),
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
    );
  }
}
