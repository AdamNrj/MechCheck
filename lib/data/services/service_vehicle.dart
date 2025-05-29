import 'dart:convert';
import 'package:http/http.dart' as http;

class ServiceVehicles {
  final String username;
  final String password;

  ServiceVehicles({required this.username, required this.password});

  Future<List<Map<String, dynamic>>> getVehiculosPorConductor(
    String idConductor,
  ) async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final Uri url = Uri.https(
      'desarrollo.fleetpad.app',
      '/fmi/odata/v4/FleetPad_des/vehiculo',
      {
        r'$filter': "idConductor eq '$idConductor'",
        r'$select': 'id,matricula,marca,modelo,idConductor',
      },
    );

    final response = await http.get(
      url,
      headers: {'Authorization': basicAuth, 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['value']);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
