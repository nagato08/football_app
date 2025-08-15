import 'package:flutter/material.dart';
import 'package:football/admin/notification_settings_page.dart';
import 'package:football/admin/security_settings_page.dart';
import 'package:football/admin/widgets/section_card.dart';
import 'package:football/admin/widgets/theme_dialog.dart';

import 'menu_item.dart';

class ApplicationSettingsSection extends StatelessWidget {
  const ApplicationSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Paramètres de l\'Application',
      subtitle: 'Configuration générale',
      icon: Icons.settings,
      items: [
        MenuItem(
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Configurer vos préférences',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationSettingsPage()),
            );
          },
        ),
        MenuItem(
          icon: Icons.language,
          title: 'Langue',
          subtitle: 'Choisir la langue de l\'interface',
          onTap: () {},
        ),
        MenuItem(
          icon: Icons.palette,
          title: 'Thème',
          subtitle: 'Personnaliser l\'apparence',
          onTap: () => showThemeDialog(context),
        ),
        MenuItem(
          icon: Icons.security,
          title: 'Sécurité',
          subtitle: 'Paramètres de sécurité',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SecuritySettingsPage()),
            );
          },
        ),

      ],
    );
  }
}