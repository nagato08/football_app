import 'package:flutter/material.dart';
import 'package:football/admin/widgets/theme_toggle_button.dart';
import '../constants/colors.dart';
import 'widgets/admin_header.dart';
import 'widgets/application_settings_section.dart';
import 'widgets/data_management_section.dart';
import 'widgets/about_section.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(

          "Administration",
          style: TextStyle(
            color: white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: primaryBlue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          ThemeToggleButton(),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AdminHeader(),
              SizedBox(height: 30),
              ApplicationSettingsSection(),
              SizedBox(height: 24),
              DataManagementSection(),
              SizedBox(height: 24),
              AboutSection(),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}