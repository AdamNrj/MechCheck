import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final Uri url = Uri.parse(
      'https://desarrollo.fleetpad.app/fmi/odata/v4/FleetPad_des/Preferencias_Usuarios'
      '?\$filter=login eq \'$username\'&\$select=login,isActivo',
    );

    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.get(
      url,
      headers: {'Authorization': basicAuth, 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['value'];
      if (data.isNotEmpty) {
        return {'success': true, 'isActive': data[0]['isActivo'] == 1};
      } else {
        return {'success': false, 'message': 'Usuario no encontrado.'};
      }
    } else if (response.statusCode == 401) {
      return {'success': false, 'message': 'Credenciales inválidas.'};
    } else {
      return {
        'success': false,
        'message': 'Error del servidor: ${response.statusCode}',
      };
    }
  }
}
