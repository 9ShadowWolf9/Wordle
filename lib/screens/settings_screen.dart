import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordle/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentTheme = themeProvider.currentTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Ustawienia')),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildThemeSwitch(
              context,
              label: 'Light Mode',
              isActive: currentTheme == AppTheme.light,
              onChanged: (value) {
                if (value) themeProvider.setTheme(AppTheme.light);
              },
            ),
            _buildThemeSwitch(
              context,
              label: 'Dark Mode',
              isActive: currentTheme == AppTheme.dark,
              onChanged: (value) {
                if (value) themeProvider.setTheme(AppTheme.dark);
              },
            ),
            _buildThemeSwitch(
              context,
              label: 'Night Mode',
              isActive: currentTheme == AppTheme.night,
              onChanged: (value) {
                if (value) themeProvider.setTheme(AppTheme.night);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSwitch(
    BuildContext context, {
    required String label,
    required bool isActive,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.surface,
              fontSize: 16,
            ),
          ),
          CupertinoSwitch(
            value: isActive,
            activeColor: Theme.of(context).colorScheme.surface,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
