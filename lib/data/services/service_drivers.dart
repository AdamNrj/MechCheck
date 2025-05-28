import 'dart:convert';
import 'package:http/http.dart' as http;

class ServiceDrivers {
  final String username;
  final String password;

  ServiceDrivers({required this.username, required this.password});

  Future<List<Map<String, dynamic>>> getConductoresPorInversor(String inversorId) async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final Uri url = Uri.parse(
      'https://desarrollo.fleetpad.app/fmi/odata/v4/FleetPad_des/conductor'
      '?\$filter=Idinversor eq $inversorId and isActivo eq true'
      '&\$select=nombreCompleto,apellido1,apellido2,isActivo,id',
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
