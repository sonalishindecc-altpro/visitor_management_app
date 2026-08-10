import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/app_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.accent,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text('SecureGate User', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('user@securegate.com', style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 32),
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.accent),
              title: const Text('Account Settings'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: AppColors.accent),
              title: const Text('Help & Support'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.help),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: AppColors.accent),
              title: const Text('About App'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.about),
            ),
            const Spacer(),
            AppButton(
              label: 'LOG OUT',
              color: AppColors.error,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
