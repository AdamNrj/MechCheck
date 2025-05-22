import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototipo_app/presentation/screens/tabs/tabs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    final user = userController.text.trim();
    final pass = passController.text.trim();

    if (user.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    setState(() => isLoading = true);

    final Uri url = Uri.parse(
      'https://desarrollo.fleetpad.app/fmi/odata/v4/FleetPad_des/Preferencias_Usuarios'
      '?\$filter=login eq \'$user\'&\$select=login,isActivo',
    );

    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$user:$pass'))}';

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': basicAuth, 'Accept': 'application/json'},
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List data = jsonResponse['value'];

        if (data.isNotEmpty) {
          final isActivo = data[0]['isActivo'];
          if (isActivo == 1) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('¡Bienvenido $user!')));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainTabs()),
            );
          } else {
            _showError('Usuario inactivo. Contacta al administrador.');
          }
        } else {
          _showError('Usuario no encontrado.');
        }
      } else if (response.statusCode == 401) {
        _showError('Credenciales inválidas.');
      } else {
        _showError('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showError('Error de red: $e');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'FleetPad',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Inicia sesión para continuar',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 48),
                  TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      hintText: 'Usuario',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passController,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child:
                          isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                'Iniciar Sesión',
                                style: TextStyle(fontSize: 16),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
