import 'package:flutter/material.dart';

import 'homePage.dart';

class FootballTeamApp extends StatelessWidget {
  const FootballTeamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Team Management',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF3852A4),
          secondary: const Color(0xFFF8D959),
          surface: Colors.white,
          background: Colors.white,
          onPrimary: Colors.white,
          onSecondary: const Color(0xFF050505),
          onSurface: const Color(0xFF050505),
          onBackground: const Color(0xFF050505),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF3852A4),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFFF8D959),
          foregroundColor: const Color(0xFF050505),
        ),
      ),
      home: const RoleBasedHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
