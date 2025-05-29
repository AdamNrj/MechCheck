import 'package:flutter/material.dart';
import 'package:prototipo_app/core/models/driver.dart';
import 'package:prototipo_app/data/services/service_drivers.dart';

class ConductorListScreen extends StatelessWidget {
  final String username;
  final String password;

  const ConductorListScreen({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final driverService = ServiceDrivers(
      username: username,
      password: password,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Conductores activos')),
      body: FutureBuilder<List<Conductor>>(
        future: driverService.getConductoresActivos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay conductores activos.'));
          }

          final conductores = snapshot.data!;

          return ListView.builder(
            itemCount: conductores.length,
            itemBuilder: (context, index) {
              final conductor = conductores[index];
              return ListTile(
                title: Text(conductor.nombreCompleto),
                subtitle: Text('Inversor: ${conductor.nombreInversor}'),
                leading: const Icon(Icons.person),
              );
            },
          );
        },
      ),
    );
  }
}
