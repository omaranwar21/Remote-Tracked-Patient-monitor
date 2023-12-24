import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patient_monitor/widgets/customBar.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reset Password"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                resetPassword();
                Navigator.pushNamed(context, 'login');
              },
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }

  void resetPassword() async {
    try {
      final String email = _emailController.text.trim();

      if (email.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        // Reset password email sent, show a success message or navigate to a success screen
      } else {
        // Display an error message or handle empty email field
      }
    } catch (e) {
      // Display an error message or handle the password reset error
      print('Password reset failed: $e');
    }
  }
}
