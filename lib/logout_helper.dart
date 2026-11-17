import 'package:flutter/material.dart';
import 'demo_auth.dart';
import 'login_screen.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Log out'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 40)),
          onPressed: () {
            DemoAuth.logout();

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          },
          child: const Text('Log out'),
        ),
      ],
    ),
  );
}

List<Widget> logoutActions(BuildContext context) {
  return [
    IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Log out',
      onPressed: () => showLogoutDialog(context),
    ),
  ];
}