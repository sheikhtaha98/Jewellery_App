import 'package:flutter/material.dart';
// import 'package:mini_project/Screens/onboardingView/onboarding_view.dart';
import 'package:ui_project/Screens/splashScreen/splashScreen.dart';

import 'Screens/MainMenuView/mainMenu_view.dart';
// import 'Screens/MainMenuView/widget/HomeScreem/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Manrope",
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/firstscreen': (context) => const MainMenuView(),
      },
    );
  }
}
