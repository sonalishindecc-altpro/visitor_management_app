import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          'Your privacy is strictly protected. All visitor logs and resident details are stored securely on Firebase encrypted databases with role-based security access control.',
          style: TextStyle(color: Colors.white70, height: 1.6),
        ),
      ),
    );
  }
}
