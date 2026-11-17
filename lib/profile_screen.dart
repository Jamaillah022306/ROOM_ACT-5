import 'package:flutter/material.dart';
import 'app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
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
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.maroon,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.maroonLight,
                    backgroundImage: AssetImage('assets/cutie.jpg'),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'JAMAILLAH SANTI',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.maroon,
                  ),
                ),
                const SizedBox(height: 24),
                const Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.badge, color: AppColors.maroon),
                        title: Text('Student ID'),
                        subtitle: Text('554449'),
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.school, color: AppColors.maroon),
                        title: Text('Course and Section'),
                        subtitle: Text('CCE 106-3450'),
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.email, color: AppColors.maroon),
                        title: Text('Email'),
                        subtitle: Text('j.santi.554449@umindanao.edu.ph'),
                      ),
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