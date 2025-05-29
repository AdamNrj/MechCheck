import 'package:flutter/material.dart';
import 'package:prototipo_app/data/services/service_vehicle.dart';

class VehiculosScreen extends StatelessWidget {
  final String username;
  final String password;
  final String conductorId;

  const VehiculosScreen({
    super.key,
    required this.username,
    required this.password,
    required this.conductorId,
  });

  @override
  Widget build(BuildContext context) {
    final service = ServiceVehicles(username: username, password: password);

    return Scaffold(
      appBar: AppBar(title: const Text('Vehículos del Conductor')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: service.getVehiculosPorConductor(conductorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay vehículos para este conductor.'),
            );
          }

          final vehiculos = snapshot.data!;
          return ListView.builder(
            itemCount: vehiculos.length,
            itemBuilder: (context, index) {
              final vehiculo = vehiculos[index];
              return ListTile(
                title: Text(vehiculo['matricula'] ?? 'Sin matrícula'),
                subtitle: Text(
                  '${vehiculo['marca'] ?? ''} ${vehiculo['modelo'] ?? ''}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
