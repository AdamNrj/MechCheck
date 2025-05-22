import 'package:flutter/material.dart';

class FleetPadScreen extends StatelessWidget {
  const FleetPadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FleetPad')),
      body: const Center(child: Text('Gestión de Flotas')),
    );
  }
}
