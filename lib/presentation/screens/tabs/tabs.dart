import 'package:flutter/material.dart';
import 'package:prototipo_app/presentation/screens/login_screen.dart';
import 'package:prototipo_app/presentation/screens/tabs/home_screen.dart';
import 'package:prototipo_app/presentation/screens/tabs/profile_screen.dart';
import 'package:prototipo_app/presentation/screens/tabs/setting_screen.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<Tabs> {
  int _currentIndex = 1;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _selectTab(int index) {
    if (_currentIndex == index) {
      _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              switch (index) {
                case 0:
                  return const SettingScreen();
                case 1:
                  return const HomeScreen();
                case 2:
                  return const ProfileScreen();
                default:
                  return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildTabItem({required IconData icon, required int index}) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _selectTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: 26,
          color: isSelected ? Colors.white : Colors.black54,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentIndex].currentState!.maybePop();
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            _currentIndex == 0
                ? 'Historial'
                : _currentIndex == 1
                ? 'Peritaje'
                : 'Perfil',
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black),
              onPressed: () => _logout(context),
              tooltip: 'Cerrar sesión',
            ),
          ],
        ),
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          currentIndex: _currentIndex,
          onTap: _selectTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
