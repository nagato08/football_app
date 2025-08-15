import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_notifier.dart';



Future<void> showThemeDialog(BuildContext context) async {
  String selected = context.read<ThemeNotifier>().value == ThemeMode.dark ? 'dark' : 'light';

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Thème'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choisir votre thème'),
            RadioListTile<String>(
              title: const Text('Clair'),
              value: 'light',
              groupValue: selected,
              onChanged: (val) => selected = val!,
            ),
            RadioListTile<String>(
              title: const Text('Sombre'),
              value: 'dark',
              groupValue: selected,
              onChanged: (val) => selected = val!,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Retour'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Appliquer'),
            onPressed: () {
              context.read<ThemeNotifier>().setTheme(selected);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}