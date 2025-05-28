// import 'package:flutter/material.dart';
// import 'package:prototipo_app/data/services/service_vehicle.dart';

// class VehiculoListScreen extends StatefulWidget {
//   final String username;
//   final String password;

//   const VehiculoListScreen({
//     super.key,
//     required this.username,
//     required this.password,
//   });

//   @override
//   State<VehiculoListScreen> createState() => _VehiculoListScreenState();
// }

// class _VehiculoListScreenState extends State<VehiculoListScreen> {
//   List<Map<String, dynamic>> _vehiculos = [];
//   bool _loading = true;

//   @override
//   void initState() {
//     super.initState();
//     _cargarVehiculos();
//   }

//   Future<void> _cargarVehiculos() async {
//     try {
//       final data = await VehicleService(
       
//       );
//       setState(() {
//       });
//     } catch (e) {
//       setState(() => _loading = false);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Lista de Vehículos')),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _vehiculos.length,
//               itemBuilder: (context, index) {
//                 final v = _vehiculos[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   child: ListTile(
//                     leading: const Icon(Icons.directions_car),
//                     title: Text(v['matricula'] ?? 'Sin matrícula'),
//                     subtitle: Text(
//                       'Marca: ${v['marca'] ?? 'N/A'}\n'
//                       'Modelo: ${v['modelo'] ?? 'N/A'}\n'
//                       'Estado: ${v['estado'] ?? 'N/A'}',
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
