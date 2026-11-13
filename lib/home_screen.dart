import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'auth_service.dart';
import 'logout_helper.dart';

class HomeScreen extends StatelessWidget {
  final void Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  Widget buildTile(IconData icon, String title, String subtitle, int index) {
    return ListTile(
      leading: Icon(icon, color: AppColors.maroon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => onNavigate(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: logoutActions(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: AppColors.maroonLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.home,
                      size: 60, color: AppColors.maroon),
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome, ${AuthService.currentUser}!',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.maroon,
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      buildTile(Icons.calculate, 'Calculator',
                          'Perform basic arithmetic operations.', 1),
                      const Divider(height: 1),
                      buildTile(Icons.person, 'Profile',
                          'View your student information.', 2),
                      const Divider(height: 1),
                      buildTile(Icons.share, 'Social Media',
                          'View your sample social accounts.', 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}