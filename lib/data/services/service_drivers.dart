import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototipo_app/core/models/driver.dart';

class ServiceDrivers {
  final String username;
  final String password;

  ServiceDrivers({required this.username, required this.password});

  Future<List<Conductor>> getConductoresActivos() async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final Uri url = Uri.https(
      'desarrollo.fleetpad.app',
      '/fmi/odata/v4/FleetPad_des/conductor',
      {
        r'$filter': 'isActivo eq true',
        r'$select': 'nombreCompleto,apellido1,nombreInversor',
      },
    );

    final response = await http.get(
      url,
      headers: {'Authorization': basicAuth, 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> values = data['value'];
      return values.map((json) => Conductor.fromJson(json)).toList();
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
