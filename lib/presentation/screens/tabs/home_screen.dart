import 'package:flutter/material.dart';
import 'package:prototipo_app/presentation/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantalla Inicial")),
      body: Center(
        child: ElevatedButton(
          child: Text("Cerrar Sesión"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
        ),
      ),
    );
  }
}
