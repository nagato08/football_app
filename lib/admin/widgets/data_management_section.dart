import 'package:flutter/material.dart';
import 'package:football/admin/widgets/section_card.dart';
import 'confirm_dialog.dart';
import 'menu_item.dart';
class DataManagementSection extends StatelessWidget {
  const DataManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Gestion des Données',
      subtitle: 'Sauvegarde et restauration',
      icon: Icons.backup,
      items: [
        MenuItem(
          icon: Icons.cloud_download,
          title: 'Sauvegarder',
          subtitle: 'Exporter les données de l’application',
          onTap: () => showConfirmDialog(
            context: context,
            title: 'Sauvegarde',
            message: 'Créer une sauvegarde complète de toutes vos données ?',
            color: Colors.green,
            icon: Icons.cloud_upload,
            confirmText: 'Sauvegarder',
            onConfirm: () {
              // logique de sauvegarde ici
            },
          ),
        ),
        MenuItem(
          icon: Icons.restore,
          title: 'Restaurer',
          subtitle: 'Importer une sauvegarde existante',
          onTap: () => showConfirmDialog(
            context: context,
            title: 'Restauration',
            message: 'Voulez-vous restaurer une sauvegarde précédente ?',
            color: Colors.orange,
            icon: Icons.restore,
            confirmText: 'Restaurer',
            onConfirm: () {
              // logique de restauration ici
            },
          ),
        ),
        MenuItem(
          icon: Icons.delete_sweep,
          title: 'Supprimer',
          subtitle: 'Supprimer les données temporaires',
          onTap: () => showConfirmDialog(
            context: context,
            title: 'Suppression',
            message: 'Êtes-vous sûr de vouloir supprimer toutes les données ? Cette action est irréversible.',
            color: Colors.red,
            icon: Icons.delete_forever,
            confirmText: 'Supprimer',
            onConfirm: () {
              // logique de suppression ici
            },
          ),
        ),
      ],
    );
  }
}