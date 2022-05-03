import 'dart:developer';

import 'package:chat_app/Libraries/lib_color_schemes.g.dart' as cl;
import 'package:chat_app/Providers/authentication.dart';
import 'package:chat_app/Providers/darkThemeProvider.dart';
import 'package:chat_app/Screens/auth_screen.dart';
import 'package:chat_app/Screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './Providers/applicationState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getThemeMode();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log("main builder");
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                  colorScheme: value.darkTheme
                      ? cl.darkColorScheme
                      : cl.lightColorScheme),
              themeMode: ThemeMode.dark,
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    return const ChatScreen();
                  } else {
                    return const AuthScreen();
                  }
                },
              )
              // home: Consumer<ApplicationState>(
              //   builder: (context, authData, _) {
              //     return authData.user == null
              //         ? const AuthScreen()
              //         : const ChatScreen();
              //   },
              // ),
              );
        },
      ),
    );
  }
}
