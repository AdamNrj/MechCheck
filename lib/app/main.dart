// import 'package:flutter/material.dart';
// import 'package:prototipo_app/ui/home.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Inspección de Vehículos',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:prototipo_app/presentation/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
