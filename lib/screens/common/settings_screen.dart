import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushEnabled = true;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Settings')),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: [
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
        ],
      ),
    );
  }
}
