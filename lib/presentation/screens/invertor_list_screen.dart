import 'package:flutter/material.dart';
import 'package:prototipo_app/core/models/invertor.dart';
import 'package:prototipo_app/data/services/service_investors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String username = 'tu_usuario'; // <- pon aquí tu usuario
  final String password = 'tu_contraseña'; // <- pon aquí tu contraseña

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PeritajeApp',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => InvestorListScreen(
              username: username,
              password: password,
            ),
      },
    );
  }
}


class InvestorListScreen extends StatelessWidget {
  final String username;
  final String password;

  const InvestorListScreen({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final investorService = ServiceInvestors(username: username, password: password);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inversores'),
      ),
      body: FutureBuilder<List<Inversor>>(
  future: investorService.getInversoresActivos(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('No hay inversores activos.'));
    }

    final inversores = snapshot.data!;

    return ListView.builder(
      itemCount: inversores.length,
      itemBuilder: (context, index) {
        final inversor = inversores[index];
        return ListTile(
          title: Text(inversor.nombreInversor),
          subtitle: Text('ID: ${inversor.id}'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/drivers',
              arguments: {
                'username': username,
                'password': password,
                'inversorId': inversor.id,
              },
            );
          },
        );
      },
    );
  },
)
    );
  }
}
