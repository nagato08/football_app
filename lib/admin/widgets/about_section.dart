import 'package:flutter/material.dart';
import 'package:football/admin/legal_page.dart';
import 'package:football/admin/team_page.dart';
import 'section_card.dart';
import 'menu_item.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'À propos',
      subtitle: 'Informations sur l’application',
      icon: Icons.info_outline,
      items: [
        MenuItem(
          icon: Icons.verified_user,
          title: 'Version',
          subtitle: 'v1.0.0',
          onTap: () {},
        ),
        MenuItem(
          icon: Icons.people,
          title: 'Équipe de développement',
          subtitle: 'Voir les membres',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TeamPage()),
            );
          },

        ),
        MenuItem(
          icon: Icons.gavel,
          title: 'Mentions légales',
          subtitle: 'Conditions d’utilisation, confidentialité',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LegalPage()),
            );
          },

        ),
        MenuItem(
          icon: Icons.help,
          title: 'Support',
          subtitle: 'Guide d\'utilisation et contact',
          onTap: () {
            // logique future pour liens externes
          },
        ),
      ],
    );
  }
}