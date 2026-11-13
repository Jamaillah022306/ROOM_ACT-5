import 'package:flutter/material.dart';
import 'app_colors.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

  Widget buildAccount(
    BuildContext context,
    IconData icon,
    String name,
    String username,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.maroon, size: 30),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(username),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$name: $username'),
              backgroundColor: AppColors.maroon,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Connect With Me',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.maroon,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Tap an account to display its username.'),
                const SizedBox(height: 20),
                buildAccount(
                    context, Icons.facebook, 'Facebook', 'student.sample'),
                buildAccount(context, Icons.camera_alt, 'Instagram',
                    '@student.sample'),
                buildAccount(context, Icons.play_circle_fill, 'YouTube',
                    '@StudentChannel'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}