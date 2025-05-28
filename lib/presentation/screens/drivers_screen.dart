// import 'package:flutter/material.dart';
// import 'package:prototipo_app/data/services/service_drivers.dart';

// class DriversScreen extends StatefulWidget {
//   final String username;
//   final String password;

//   const DriversScreen({required this.username, required this.password, super.key});

//   @override
//   State<DriversScreen> createState() => _ConductoresScreenState();
// }

// class _ConductoresScreenState extends State<DriversScreen> {
//   late Future<List<Map<String, dynamic>>> _futureConductores;

//   @override
//   void initState() {
//     super.initState();
//     _futureConductores = ServiceDrivers(
//       username: widget.username,
//       password: widget.password,
//     ).getConductoresActivos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Conductores Activos')),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _futureConductores,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No hay conductores activos.'));
//           }

//           final conductores = snapshot.data!;

//           return ListView.builder(
//             itemCount: conductores.length,
//             itemBuilder: (context, index) {
//               final c = conductores[index];
//               return ListTile(
//                 leading: const Icon(Icons.person),
//                 title: Text(c['nombreCompleto'] ?? 'Sin nombre'),
//                 subtitle: Text('${c['apellido1'] ?? ''} ${c['apellido2'] ?? ''}'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
