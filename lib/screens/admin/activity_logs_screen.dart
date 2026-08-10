import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class ActivityLogsScreen extends StatelessWidget {
  const ActivityLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('System Audit Logs')),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: const [
          LogItem(action: 'Visitor Approved', by: 'Anita Verma', time: '10 mins ago'),
          LogItem(action: 'New Guard Added', by: 'Admin Vikram', time: '1 hour ago'),
          LogItem(action: 'QR Pass Generated', by: 'Sunil Kumar', time: '3 hours ago'),
        ],
      ),
    );
  }
}

class LogItem extends StatelessWidget {
  final String action, by, time;
  const LogItem({super.key, required this.action, required this.by, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.history_toggle_off, color: AppColors.accent),
        title: Text(action, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('By $by'),
        trailing: Text(time, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ),
    );
  }
}
