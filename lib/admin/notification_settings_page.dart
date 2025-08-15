import 'package:flutter/material.dart';
import 'package:football/admin/themes/app_theme.dart';
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool allNotifications = true;
  bool matchReminder = true;
  bool resultAlert = true;
  bool systemUpdates = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: primaryBlue,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: allNotifications,
            activeColor: primaryBlue,
            title: const Text('Activer toutes les notifications'),
            subtitle: const Text('Activer ou désactiver toutes les alertes'),
            onChanged: (val) {
              setState(() {
                allNotifications = val;
                matchReminder = val;
                resultAlert = val;
                systemUpdates = val;
              });
            },
          ),
          const Divider(height: 30),
          SwitchListTile(
            value: matchReminder,
            activeColor: primaryBlue,
            title: const Text('Rappels de match'),
            subtitle: const Text('Recevoir une alerte avant les matchs'),
            onChanged: allNotifications
                ? (val) => setState(() => matchReminder = val)
                : null,
          ),
          SwitchListTile(
            value: resultAlert,
            activeColor: primaryBlue,
            title: const Text('Résultats'),
            subtitle: const Text('Recevoir une notification après chaque match'),
            onChanged: allNotifications
                ? (val) => setState(() => resultAlert = val)
                : null,
          ),
          SwitchListTile(
            value: systemUpdates,
            activeColor: primaryBlue,
            title: const Text('Mises à jour système'),
            subtitle: const Text('Recevoir des infos sur les mises à jour'),
            onChanged: allNotifications
                ? (val) => setState(() => systemUpdates = val)
                : null,
          ),
        ],
      ),
    );
  }
}