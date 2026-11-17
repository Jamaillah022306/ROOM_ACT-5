import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'demo_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  void register() {
    final username = usernameController.text.trim();
    final password = passwordController.text;
    final confirm = confirmController.text;

    if (username.isEmpty || password.isEmpty || confirm.isEmpty) {
      showMessage('Please fill in all fields.');
      return;
    }
    if (username.length < 3) {
      showMessage('Username must contain at least three characters.');
      return;
    }
    if (username.toLowerCase() == 'admin') {
      showMessage('The username admin is reserved.');
      return;
    }
    if (password.length < 6) {
      showMessage('Password must contain at least six characters.');
      return;
    }
    if (password != confirm) {
      showMessage('Passwords do not match.');
      return;
    }

    // Save the account
    DemoAuth.register(
      usernameController.text.trim(),
      passwordController.text,
    );

    showMessage('Account created! You can now log in.');

    // Return to Login
    Navigator.of(context).pop();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.maroon),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.person_add,
                    size: 80, color: AppColors.maroon),
                const SizedBox(height: 16),
                const Text(
                  'Create an Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.maroon,
                  ),
                ),
                const SizedBox(height: 28),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person, color: AppColors.maroon),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: AppColors.maroon),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon:
                        Icon(Icons.lock_outline, color: AppColors.maroon),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: register, child: const Text('Register')),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}