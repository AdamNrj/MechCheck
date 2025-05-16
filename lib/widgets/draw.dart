import 'package:flutter/material.dart';

class _QuickAccessDrawer extends StatelessWidget {
  const _QuickAccessDrawer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 300,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: const [
          _QuickAccess(icon: Icons.checklist, label: "Checklist"),
          _QuickAccess(icon: Icons.photo, label: "Fotos"),
          _QuickAccess(icon: Icons.article, label: "Reportes"),
          _QuickAccess(icon: Icons.settings, label: "Ajustes"),
        ],
      ),
    );
  }
}

class _QuickAccess extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickAccess({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
