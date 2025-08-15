import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundGradient = isDark
        ? LinearGradient(colors: [Colors.grey[900]!, Colors.grey[800]!])
        : LinearGradient(colors: [primaryBlue, primaryBlue.withOpacity(0.8)]);

    final textColor = isDark ? Colors.white : Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: accentYellow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.admin_panel_settings, size: 40, color: primaryBlue),
          ),
          const SizedBox(height: 16),
          Text(
            'Panneau d\'Administration',
            style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Configurez votre application',
            style: TextStyle(color: textColor.withOpacity(0.9), fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}