import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  bool iaEnabled = true;
  bool notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const ProfileCard(),
              const SizedBox(height: 20),
              SettingsCard(
                isDarkMode: isDarkMode,
                iaEnabled: iaEnabled,
                notificationsEnabled: notificationsEnabled,
                onToggleDarkMode: () => setState(() => isDarkMode = !isDarkMode),
                onToggleIA: (value) => setState(() => iaEnabled = value),
                onToggleNotifications: (value) => setState(() => notificationsEnabled = value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Juan Pérez',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text('Perito Certificado',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Nivel Experto',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                MetricItem(count: '47', label: 'Completados', color: Colors.blue),
                MetricItem(count: '5', label: 'En progreso', color: Colors.orange),
                MetricItem(count: '98%', label: 'Precisión', color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MetricItem extends StatelessWidget {
  final String count;
  final String label;
  final Color color;

  const MetricItem({
    super.key,
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class SettingsCard extends StatelessWidget {
  final bool isDarkMode;
  final bool iaEnabled;
  final bool notificationsEnabled;
  final VoidCallback onToggleDarkMode;
  final ValueChanged<bool> onToggleIA;
  final ValueChanged<bool> onToggleNotifications;

  const SettingsCard({
    super.key,
    required this.isDarkMode,
    required this.iaEnabled,
    required this.notificationsEnabled,
    required this.onToggleDarkMode,
    required this.onToggleIA,
    required this.onToggleNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Configuración',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Modo Oscuro'),
                IconButton(
                  icon: const Icon(Icons.dark_mode_outlined),
                  onPressed: onToggleDarkMode,
                ),
              ],
            ),
            SwitchListTile(
              value: iaEnabled,
              onChanged: onToggleIA,
              title: const Text('Análisis IA Automático'),
              activeColor: Colors.blue, 
              activeTrackColor: Colors.blueAccent, 
              inactiveThumbColor: Colors.grey, 
              inactiveTrackColor: Colors.grey.shade300, 
            ),
            SwitchListTile(
              value: notificationsEnabled,
              onChanged: onToggleNotifications,
              title: const Text('Notificaciones'),
              activeColor: Colors.blue, 
              activeTrackColor: Colors.blueAccent, 
              inactiveThumbColor: Colors.grey, 
              inactiveTrackColor: Colors.grey.shade300, 
            ),
          ],
        ),
      ),
    );
  }
}
