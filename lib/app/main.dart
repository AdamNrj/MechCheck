import 'package:flutter/material.dart';
import 'package:prototipo_app/presentation/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PeritajeApp',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


