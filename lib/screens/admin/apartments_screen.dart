import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class ApartmentsScreen extends StatelessWidget {
  const ApartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apartment Directory')),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: const [
          AptTile(no: 'A-101', resident: 'Sunil Kumar', status: 'Occupied'),
          AptTile(no: 'A-102', resident: 'Anita Verma', status: 'Occupied'),
          AptTile(no: 'B-201', resident: 'Vacant', status: 'Available'),
        ],
      ),
    );
  }
}

class AptTile extends StatelessWidget {
  final String no, resident, status;
  const AptTile({super.key, required this.no, required this.resident, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.home, color: AppColors.accent),
        title: Text('Flat $no', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Resident: $resident'),
        trailing: Chip(
          label: Text(status, style: const TextStyle(fontSize: 10)),
          backgroundColor: status == 'Occupied' ? AppColors.success.withOpacity(0.2) : Colors.white10,
        ),
      ),
    );
  }
}
