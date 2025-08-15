import 'package:flutter/material.dart';

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  bool biometricEnabled = false;
  bool autoLogout = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sécurité'),
        backgroundColor: const Color(0xFF3852A4),
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Modifier le mot de passe'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // ouvrir showDialog ou page de changement
              _showChangePasswordDialog(context);
            },
          ),
          const Divider(height: 30, color: Color(0xFF3852A4)),
          SwitchListTile(
            value: biometricEnabled,
            activeColor: const Color(0xFF3852A4),
            title: const Text('Authentification biométrique'),
            subtitle: const Text('Utiliser l’empreinte ou le visage'),
            onChanged: (val) {
              setState(() => biometricEnabled = val);
              // Tu peux gérer la logique d'enregistrement ici
            },
          ),
          const Divider(height: 30, color: Color(0xFF3852A4)),
          SwitchListTile(
            value: autoLogout,
            activeColor: const Color(0xFF3852A4),
            title: const Text('Déconnexion automatique'),
            subtitle: const Text('Déconnexion après inactivité'),
            onChanged: (val) {
              setState(() => autoLogout = val);
              // Tu peux aussi l'enregistrer dans Hive si besoin
            },
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldController = TextEditingController();
    final newController = TextEditingController();
    final confirmController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        Theme.of(context);
        return AlertDialog(
          title: const Text('Modifier le mot de passe'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Ancien mot de passe'),
              ),
              TextField(
                controller: newController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Nouveau mot de passe'),
              ),
              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirmer le nouveau mot de passe'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {
                // ici on vérifierait les valeurs
                Navigator.pop(context);
                // tu peux afficher une confirmation
              },
              child: const Text('Valider'),
            ),
          ],
        );
      },
    );
  }
}