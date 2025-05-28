import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchBarWidget(),
              const SizedBox(height: 16),                                                            
              const AnalysisIAWidget(),
              const SizedBox(height: 24),
              const ActionButtonsWidget(),
              const SizedBox(height: 32),
              const RecentReportsHeader(),
              const SizedBox(height: 12),
              const RecentReportTile(
                title: 'BMW X5 - Daño frontal',
                timeAgo: 'Hace 2 horas',
                icon: Icons.directions_car,
                iaEnabled: true,
                statusColor: Colors.orange,
              ),
              const RecentReportTile(
                title: 'Casa residencial - Grietas',
                timeAgo: 'Ayer',
                icon: Icons.house,
                iaEnabled: false,
                statusColor: Colors.blue,
              ),
              const RecentReportTile(
                title: 'iPhone 14 - Pantalla rota',
                timeAgo: 'Hace 3 días',
                icon: Icons.phone_iphone,
                iaEnabled: true,
                statusColor: Colors.red,
              ),
              const SizedBox(height: 24),
              const Interactive3DViewCard(),
            ],
          ),
        ),
      ),
    );
  }
}



class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _hasText = _controller.text.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Buscar peritajes...',
                border: InputBorder.none,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: _animationDuration,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: _hasText
                ? IconButton(
                    key: const ValueKey('clear'),
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      _controller.clear();
                      FocusScope.of(context).unfocus();
                    },
                  )
                : const SizedBox.shrink(key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }
}



class AnalysisIAWidget extends StatelessWidget {
  const AnalysisIAWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
        color: Colors.blue[50],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.auto_fix_high, color: Colors.blue),
              SizedBox(width: 8),
              Text('Análisis con IA', style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text('Próximamente', style: TextStyle(color: Colors.blueGrey)),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Detección automática de daños'),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.flash_on),
            label: Text('Activar Análisis Inteligente'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Expanded(child: ActionButton(icon: Icons.add, label: 'Nuevo Peritaje', description: 'Crear informe detallado', color: Colors.blue)),
        SizedBox(width: 16),
        Expanded(child: ActionButton(icon: Icons.photo_camera, label: 'Captura 3D', description: 'Escaneo avanzado', color: Colors.orange)),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Color color;

  const ActionButton({
    required this.icon,
    required this.label,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: color),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(color: Colors.grey), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Interactive3DViewCard extends StatelessWidget {
  const Interactive3DViewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.view_in_ar, color: Colors.white, size: 40),
          SizedBox(height: 12),
          Text(
            'Vista 3D Interactiva',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            'Explora modelos 3D con interacción en tiempo real.',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class RecentReportsHeader extends StatelessWidget {
  const RecentReportsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Informes Recientes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('Ver todos', style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}

class RecentReportTile extends StatelessWidget {
  final String title;
  final String timeAgo;
  final IconData icon;
  final bool iaEnabled;
  final Color statusColor;

  const RecentReportTile({
    required this.title,
    required this.timeAgo,
    required this.icon,
    required this.iaEnabled,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(timeAgo, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          if (iaEnabled)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(Icons.psychology, color: Colors.purple),
            ),
          Container(width: 10, height: 10, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          const Icon(Icons.visibility),
        ],
      ),
    );
  }
}


