import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_notifier.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      onPressed: () {
        final newTheme = isDark ? 'light' : 'dark';
        context.read<ThemeNotifier>().setTheme(newTheme);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) => RotationTransition(
          turns: child.key == const ValueKey('icon-sun')
              ? Tween<double>(begin: 0.75, end: 1).animate(animation)
              : Tween<double>(begin: 0.25, end: 1).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: isDark
            ? const Icon(Icons.wb_sunny, key: ValueKey('icon-sun'), color: Colors.amber)
            : const Icon(Icons.nightlight, key: ValueKey('icon-moon'), color: Colors.amber),
      ),
      tooltip: isDark ? 'Passer en mode clair' : 'Passer en mode sombre',
    );
  }
}