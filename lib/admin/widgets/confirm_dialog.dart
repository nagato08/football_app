import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required Color color,
  required IconData icon,
  required String confirmText,
  required VoidCallback onConfirm,
}) async {
  final bgColor = Theme.of(context).cardColor;
  final textColor = Theme.of(context).textTheme.bodyLarge!.color;

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialog(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            radius: 24,
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 12),
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 12),
          Text(message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: textColor?.withOpacity(0.8))),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 👈 plus petit rayon
                  ),
                ),
                child: Text("Annuler", style: TextStyle(color: textColor)),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 👈 même radius
                  ),
                ),
                child: Text(confirmText, style: const TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
              ),

            ],
          ),
        ],
      ),
    ),
  );
}