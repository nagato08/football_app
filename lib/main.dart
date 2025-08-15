import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:football/screens/dashboard.dart';
import 'package:football/screens/dashboardadmin.dart';
import 'package:football/screens/dashboardcoach.dart';
import 'package:football/screens/dashboardjoueur.dart';
import 'package:football/screens/login_screen.dart';
import 'package:football/screens/profildirecteursportif.dart';
import 'package:football/screens/profilejoueur.dart';
import 'package:football/screens/select_profil_screen.dart';
import 'admin/admin_page.dart';
import 'admin/legal_page.dart';
import 'admin/notification_settings_page.dart';
import 'admin/security_settings_page.dart';
import 'admin/team_page.dart';
import 'admin/widgets/about_section.dart';
import 'admin/widgets/admin_header.dart';
import 'admin/widgets/application_settings_section.dart';
import 'admin/widgets/data_management_section.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AdminPage(),
    );
  }
}
