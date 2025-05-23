import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>?> fetchData(String token) async {
  final url = Uri.parse('https://api.tuapp.com/data');

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Si la API requiere token
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // Suponiendo que devuelve una lista JSON
    return data as List<dynamic>;
  } else {
    print('Error al obtener datos: ${response.statusCode}');
    return null;
  }
}
