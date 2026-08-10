import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About SecureGate')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shield, size: 80, color: AppColors.accent),
              SizedBox(height: 16),
              Text(AppStrings.appName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Version 1.0.0', style: TextStyle(color: Colors.white54)),
              SizedBox(height: 16),
              Text(
                'Complete Security & Visitor Management Solution for Residential Societies.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
