import 'package:flutter/material.dart';
import 'package:football/constants/colors.dart';

class LegalSection {
  final String title;
  final String content;
  final IconData icon;

  const LegalSection({
    required this.title,
    required this.content,
    required this.icon,
  });
}

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      const LegalSection(
        icon: Icons.assignment,
        title: 'Conditions d\'utilisation',
        content: '''
1. Acceptation des conditions
En utilisant cette application, vous acceptez pleinement et sans réserve les présentes conditions d'utilisation.

2. Utilisation autorisée
Cette application est destinée exclusivement à la gestion interne du club de football. Toute utilisation commerciale ou de revente est strictement interdite.

3. Restrictions
Il est interdit de :
- Copier ou reproduire le contenu sans autorisation
- Utiliser l'application à des fins illégales
- Tenter de compromettre la sécurité du système

4. Modifications
Le club se réserve le droit de modifier ces conditions à tout moment. Les utilisateurs seront informés des changements majeurs.
''',
      ),
      const LegalSection(
        icon: Icons.privacy_tip,
        title: 'Politique de confidentialité',
        content: '''
1. Données collectées
Nous collectons uniquement les données nécessaires au fonctionnement de l'application :
- Nom et prénom
- Adresse email
- Rôle dans le club
- Données de connexion

2. Protection des données
Toutes les données sont :
- Cryptées lors du transfert (SSL/TLS)
- Stockées sur des serveurs sécurisés en UE
- Accessibles uniquement par le personnel autorisé

3. Durée de conservation
Les données sont conservées pendant la durée d'adhésion au club et supprimées dans un délai de 30 jours après la fin de l'adhésion.

4. Droits des utilisateurs
Conformément au RGPD, vous pouvez :
- Accéder à vos données
- Demander leur rectification
- Demander leur suppression
''',
      ),
      const LegalSection(
        icon: Icons.gavel,
        title: 'Responsabilité',
        content: '''
1. Limitation de responsabilité
L'équipe de développement décline toute responsabilité pour :
- Les interruptions de service non planifiées
- Les pertes de données dues à des cas de force majeure
- L'utilisation non conforme de l'application

2. Garanties
L'application est fournie "en l'état" sans garantie d'aucune sorte, expresse ou implicite.

3. Maintenance
Le club s'engage à :
- Maintenir l'application opérationnelle
- Corriger les bugs majeurs dans un délai raisonnable
- Informer les utilisateurs des maintenances programmées

4. Contact
Pour toute question juridique : legal@clubfootball.fr
''',
      ),
      const LegalSection(
        icon: Icons.copyright,
        title: 'Propriété intellectuelle',
        content: '''
1. Droits d'auteur
L'ensemble du contenu (textes, images, logos) est la propriété exclusive du club.

2. Licence
L'utilisation de l'application ne confère aucun droit de propriété intellectuelle sur les éléments de l'application.

3. Marques déposées
Le nom et le logo du club sont des marques déposées. Toute reproduction non autorisée est interdite.

4. Contenu utilisateur
Les utilisateurs conservent les droits sur le contenu qu'ils créent mais accordent au club une licence d'utilisation.
''',
      ),
    ];

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mentions légales',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: white),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dernière mise à jour : 01/01/2024',
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: theme.hintColor,
              ),
            ),
            const SizedBox(height: 20),
            ...sections.map((section) => _buildLegalSection(context, section)).expand(
                  (widget) => [widget, const SizedBox(height: 30)],
            ),
            Divider(
              height: 40,
              color: theme.dividerColor,
            ),
            _buildContactCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalSection(BuildContext context, LegalSection section) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(section.icon, color: theme.colorScheme.primary, size: 28),
            const SizedBox(width: 12),
            Text(
              section.title,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
          ),
          child: Text(
            section.content,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Besoin d\'aide ?',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Pour toute question concernant les mentions légales ou la protection de vos données :',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(Icons.email, color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'amarketch@gmail.com',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.blue.shade800,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  '+237 653249287',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}