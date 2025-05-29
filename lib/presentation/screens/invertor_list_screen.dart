import 'package:flutter/material.dart';
import 'package:prototipo_app/core/models/invertor.dart';
import 'package:prototipo_app/data/services/service_investors.dart';

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
    final investorService = ServiceInvestors(
      username: username,
      password: password,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Inversores',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Inversor>>(
        future: investorService.getInversoresActivos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay inversores activos.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final inversores = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: inversores.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final inversor = inversores[index];

              return InkWell(
                onTap: () {
                  // Acción al tocar inversor
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          inversor.nombreInversor[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              inversor.nombreInversor,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'ID: ${inversor.id}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
