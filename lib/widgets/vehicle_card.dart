import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  final Map<String, dynamic> vehicle;
  final VoidCallback? onTap;

  const VehicleCard({super.key, required this.vehicle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.directions_car, color: Colors.blue),
        title: Text('${vehicle['marca'] ?? 'Marca'} - ${vehicle['modelo'] ?? 'Modelo'}'),
        subtitle: Text('Matrícula: ${vehicle['matricula'] ?? 'N/A'}\nEstado: ${vehicle['estado'] ?? 'Desconocido'}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        isThreeLine: true,
        onTap: onTap,
      ),
    );
  }
}
