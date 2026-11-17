import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'demo_auth.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'social_media/social_media.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      HomeScreen(onNavigate: changeTab),
      const CalculatorScreen(),
      const ProfileScreen(),
      SocialMediaPage(
        username: DemoAuth.currentUsername!,
      ),
    ];
  }

  void changeTab(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
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