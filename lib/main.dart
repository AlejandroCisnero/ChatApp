import 'dart:developer';

import 'package:chat_app/Libraries/lib_color_schemes.g.dart' as cl;
import 'package:chat_app/Providers/sharedPreferencesHelper.dart';
import 'package:chat_app/Screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Providers/applicationState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> getUserThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool("isDarkMode") ?? false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log("main builder");
    return FutureBuilder<bool>(
        future: SharedPreferencesHelper.getUserThemeMode(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            if (snap.data == true) {
              return GetMaterialApp(
                title: 'Flutter Demo',
                darkTheme: ThemeData(colorScheme: cl.darkColorScheme),
                theme: ThemeData(colorScheme: cl.lightColorScheme),
                themeMode: ThemeMode.dark,
                home: const AuthScreen(),
              );
            } else {
              return GetMaterialApp(
                title: 'Flutter Demo',
                darkTheme: ThemeData(colorScheme: cl.darkColorScheme),
                theme: ThemeData(colorScheme: cl.lightColorScheme),
                themeMode: ThemeMode.light,
                home: const AuthScreen(),
              );
            }
          } else {
            return GetMaterialApp(
              title: 'Flutter Demo',
              darkTheme: ThemeData(colorScheme: cl.darkColorScheme),
              theme: ThemeData(colorScheme: cl.lightColorScheme),
              themeMode: ThemeMode.system,
              home: const AuthScreen(),
            );
          }
        });
  }
}
