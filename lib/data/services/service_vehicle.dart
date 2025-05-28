import 'dart:convert';
import 'package:http/http.dart' as http;

class ServiceVehicle {
  final String username;
  final String password;

  ServiceVehicle({required this.username, required this.password});

  Future<List<Map<String, dynamic>>> getVehiculosPorConductor(String conductorId) async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final Uri url = Uri.parse(
      'https://desarrollo.fleetpad.app/fmi/odata/v4/FleetPad_des/vehiculo'
      '?\$filter=Idconductor eq $conductorId'
      '&\$select=matricula,marca,modelo,estado',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': basicAuth,
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['value']);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:prototipo_app/core/models/vehicle_model.dart';

// class ServiceVehicle {
//   final String username;
//   final String password;

//   ServiceVehicle({required this.username, required this.password});

//   Future<List<Vehicle>> getVehiculos() async {
//     final String basicAuth =
//         'Basic ${base64Encode(utf8.encode('$username:$password'))}';

//     final Uri url = Uri.parse(
//       'https://desarrollo.fleetpad.app/fmi/odata/v4/FleetPad_des/vehiculo?\$select=matricula,marca,modelo,estado',
//     );

//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': basicAuth,
//         'Accept': 'application/json',
//       },
//     );

//     print('Status code: ${response.statusCode}');
//     print('Response body: ${response.body}');

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final List<dynamic> vehiclesJson = data['value'];
//       // Convertir lista de mapas a lista de objetos Vehicle
//       return vehiclesJson.map((json) => Vehicle.fromJson(json)).toList();
//     } else {
//       throw Exception('Error ${response.statusCode}: ${response.body}');
//     }
//   }
// }
