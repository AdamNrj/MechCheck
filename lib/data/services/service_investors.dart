import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototipo_app/core/models/invertor.dart';

class ServiceInvestors {
  final String username;
  final String password;

  ServiceInvestors({required this.username, required this.password});

  Future<List<Inversor>> getInversoresActivos() async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final Uri url = Uri.https(
      'desarrollo.fleetpad.app',
      '/fmi/odata/v4/FleetPad_des/inversor',
      {r'$select': 'nombreInversor'},
    );

    final response = await http.get(
      url,
      headers: {'Authorization': basicAuth, 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> values = data['value'];

      return values.map((json) => Inversor.fromJson(json)).toList();
    } else {
      print('Error ${response.statusCode}: ${response.body}');
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
