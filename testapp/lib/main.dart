import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:testapp/constants/routes.dart';
import 'package:testapp/services/auth/auth_services.dart';

import 'package:testapp/views/home_view.dart';
import 'package:testapp/views/landing.dart';
import 'package:testapp/views/main_view.dart';
import 'package:testapp/views/sign_in.dart';
import 'package:testapp/views/sign_up.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    ColorScheme lightColorScheme;
    ColorScheme darkColorScheme;

    if (lightDynamic != null && darkDynamic != null) {
      lightColorScheme = lightDynamic.harmonized().copyWith();
      darkColorScheme = darkDynamic.harmonized()..copyWith();
    } else {
      lightColorScheme = ColorScheme.fromSeed(
        seedColor: Colors.red,
        brightness: Brightness.light,
      );

      darkColorScheme = ColorScheme.fromSeed(
        seedColor: Colors.green,
        brightness: Brightness.dark,
      );
    }
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: lightColorScheme,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: const MyApp(),
      routes: {
        signInRoute: (context) => const SignIn(),
        singUpRoute: (context) => const SignUp(),
        homeRoute: (context) => const MyHomePage(),
      },
    );
  }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initalize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              return const MyHomePage();
            } else {
              return const Landing();
            }

          default:
            return const Landing();
        }
      },
    );
  }
}
