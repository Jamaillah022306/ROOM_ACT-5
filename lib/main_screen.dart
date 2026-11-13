import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'social_media_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void changeTab(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onNavigate: changeTab),
      const CalculatorScreen(),
      const ProfileScreen(),
      const SocialMediaScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: changeTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.calculate_outlined), label: 'Calculator'),
          NavigationDestination(
              icon: Icon(Icons.person_outline), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.share), label: 'Social Media'),
        ],
      ),
    );
  }
}