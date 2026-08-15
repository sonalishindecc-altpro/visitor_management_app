import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../widgets/app_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushEnabled = true;
  bool _soundEnabled = true;

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primaryLight,
        title: const Text('Delete Account', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to permanently delete your account? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: Colors.white60)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _handleDeleteAccount();
            },
            child: const Text('DELETE', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  Future<void> _handleDeleteAccount() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    try {
      final success = await authService.deleteAccount();
      
      if (!mounted) return;
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully')),
        );
        // Navigate to splash/login and clear stack
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.splash, (route) => false);
      }
    } catch (e) {
      if (!mounted) return;
      
      String message = 'Failed to delete account. $e';
      if (e.toString().contains('requires-recent-login')) {
        message = 'Please log out and log in again before deleting your account for security reasons.';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Settings')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  activeColor: AppColors.accent,
                  title: const Text('Push Notifications'),
                  subtitle: const Text('Receive gate alerts instantly'),
                  value: _pushEnabled,
                  onChanged: (val) => setState(() => _pushEnabled = val),
                ),
                SwitchListTile(
                  activeColor: AppColors.accent,
                  title: const Text('Alert Sound'),
                  subtitle: const Text('Play sound on incoming visitor request'),
                  value: _soundEnabled,
                  onChanged: (val) => setState(() => _soundEnabled = val),
                ),
                const Divider(height: 32, color: Colors.white12),
                const Text(
                  'Account Actions',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
                  title: const Text('Delete Account', style: TextStyle(color: Colors.redAccent)),
                  subtitle: const Text('Permanently remove your data', style: TextStyle(color: Colors.white54)),
                  onTap: _showDeleteConfirmation,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingLg),
            child: AppButton(
              label: 'LOGOUT',
              onPressed: () async {
                await Provider.of<AuthService>(context, listen: false).signOut();
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
