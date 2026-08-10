import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.notifications_active, color: AppColors.accent),
              title: Text('Visitor Approval Request'),
              subtitle: Text('Ramesh Sharma is at the main gate for A-102.'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle, color: AppColors.success),
              title: Text('Visitor Approved'),
              subtitle: Text('Gate allowed entry for Mahesh Kulkarni.'),
            ),
          ),
        ],
      ),
    );
  }
}
