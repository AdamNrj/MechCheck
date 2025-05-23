import 'package:flutter/material.dart';

class FleetPadScreen extends StatelessWidget {
  const FleetPadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('FleetPad'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _fleetCard("Unidades", Icons.local_shipping, "12"),
          _fleetCard("En mantenimiento", Icons.build, "4"),
          _fleetCard("Activos", Icons.check_circle_outline, "8"),
          _fleetCard("Inactivos", Icons.cancel_outlined, "2"),
        ],
      ),
    );
  }

  Widget _fleetCard(String title, IconData icon, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.black87),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
