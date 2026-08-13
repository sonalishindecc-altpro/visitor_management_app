import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class ApartmentsScreen extends StatelessWidget {
  const ApartmentsScreen({super.key});

  void _showAddApartmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Apartment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Apartment Number (e.g. A-101)')),
            TextField(decoration: const InputDecoration(labelText: 'Resident Name')),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Status'),
              items: ['Occupied', 'Available'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) {},
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
            child: const Text('Add', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        onPressed: () => _showAddApartmentDialog(context),
        child: const Icon(Icons.add, color: Colors.black),
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
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
      color: AppColors.primaryLight.withOpacity(0.5),
      child: ListTile(
        leading: const Icon(Icons.home, color: AppColors.accent),
        title: Text('Flat $no', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text('Resident: $resident', style: TextStyle(color: Colors.white.withOpacity(0.6))),
        trailing: Chip(
          label: Text(status, style: const TextStyle(fontSize: 10, color: Colors.white)),
          backgroundColor: status == 'Occupied' ? AppColors.success.withOpacity(0.2) : Colors.white10,
        ),
      ),
    );
  }
}
