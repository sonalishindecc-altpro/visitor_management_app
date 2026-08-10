import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class VisitorHistoryScreen extends StatelessWidget {
  const VisitorHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Visitor History')),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle, color: AppColors.success),
              title: Text('Mahesh Kulkarni'),
              subtitle: Text('Guest • Yesterday 4:30 PM'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.history, color: AppColors.info),
              title: Text('Flipkart Courier'),
              subtitle: Text('Delivery • 3 Aug 2026'),
            ),
          ),
        ],
      ),
    );
  }
}
