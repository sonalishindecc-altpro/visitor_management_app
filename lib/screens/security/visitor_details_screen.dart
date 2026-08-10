import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../models/visitor_model.dart';
import '../../widgets/app_button.dart';
import '../../widgets/status_badge.dart';

class VisitorDetailsScreen extends StatelessWidget {
  final VisitorModel? visitor;
  const VisitorDetailsScreen({super.key, this.visitor});

  @override
  Widget build(BuildContext context) {
    final v = visitor ?? VisitorModel(
      id: 'v1',
      name: 'Ramesh Sharma',
      phone: '9876543210',
      purpose: 'Guest',
      status: VisitorStatus.pending,
      hostId: 'h1',
      hostName: 'Anita Verma',
      apartmentId: 'a1',
      apartmentNo: 'A-102',
      checkInTime: DateTime.now(),
      createdBy: 'guard1',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Details')),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.accent,
              child: Text(v.name[0], style: const TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            Text(v.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            StatusBadge(status: v.status),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _detailRow('Phone', v.phone),
                    _detailRow('Host Resident', v.hostName),
                    _detailRow('Apartment Unit', v.apartmentNo),
                    _detailRow('Purpose', v.purposeDisplayName),
                    _detailRow('Check-in Time', '${v.checkInTime.hour}:${v.checkInTime.minute}'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            AppButton(
              label: 'CHECK OUT VISITOR',
              color: AppColors.error,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Visitor checked out successfully.')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
