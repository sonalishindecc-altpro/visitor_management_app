import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: const [
          UserTile(name: 'Rajesh Sharma', role: 'Security Guard', email: 'rajesh@gate.com'),
          UserTile(name: 'Anita Verma', role: 'Resident (A-102)', email: 'anita@res.com'),
          UserTile(name: 'Vikram Singh', role: 'Administrator', email: 'admin@securegate.com'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {},
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final String name, role, email;
  const UserTile({super.key, required this.name, required this.role, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.accent,
          child: Text(name[0], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$role • $email'),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}
