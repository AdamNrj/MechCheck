import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthResult {
  final bool success;
  final String message;
  final String? perfil;

  AuthResult({required this.success, required this.message, this.perfil});
}

class AuthService {
  static Future<AuthResult> login(String name, String password) async {
    if (name.isEmpty || password.isEmpty) {
      return AuthResult(
        success: false,
        message: 'El usuario y la contraseña no pueden estar vacíos.',
      );
    }

    // URL base del servidor de FileMaker
    const String baseUrl =
        'https://desarrollo.fleetpad.app/fmi/odata/v4/FleetPad_des';

    // Construcción del endpoint con filtro por login
    final Uri url = Uri.parse(
      '$baseUrl/Preferencias_Usuarios'
      '?\$filter=login eq \'$name\''
      '&\$select=login,isActivo',
    );

    // Credenciales codificadas en base64 para Basic Auth
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$name:$password'))}';

    try {
      final response = await http
          .get(
            url,
            headers: {'Authorization': basicAuth, 'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(response.body);
          final List data = json['value'];

          if (data.isEmpty) {
            return AuthResult(
              success: false,
              message: 'Usuario no encontrado.',
            );
          }

          final user = data[0];
          final isActivo = user['isActivo'] == 1;

          if (!isActivo) {
            return AuthResult(
              success: false,
              message: 'Este usuario está inactivo. Contacta al administrador.',
            );
          }

          // Puedes adaptar esto si luego necesitas expandir el perfil
          return AuthResult(
            success: true,
            message: 'Login correcto.',
            perfil: null, // Ajustar si usas perfiles luego
          );

        case 401:
          return AuthResult(
            success: false,
            message: 'Credenciales inválidas (401 Unauthorized).',
          );

        case 403:
          return AuthResult(
            success: false,
            message: 'Acceso prohibido (403 Forbidden).',
          );

        case 404:
          return AuthResult(
            success: false,
            message: 'Ruta no encontrada (404 Not Found).',
          );

        case 500:
          return AuthResult(
            success: false,
            message: 'Error interno del servidor (500 Internal Server Error).',
          );

        default:
          return AuthResult(
            success: false,
            message:
                'Error inesperado (${response.statusCode}). Verifica con soporte.',
          );
      }
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Error de red o tiempo de espera: ${e.toString()}',
      );
    }
  }
}
