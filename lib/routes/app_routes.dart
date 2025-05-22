import 'package:flutter/material.dart';
import 'package:prototipo_app/presentation/screens/tabs/home_screen.dart';

class AppRoutes {
  // static const String intro = '/intro';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    // intro: (context) => const Intro(),
    home: (context) => HomeScreen(),
  };
}
