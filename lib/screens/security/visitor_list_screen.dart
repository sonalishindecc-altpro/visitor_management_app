import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../models/visitor_model.dart';
import '../../widgets/visitor_card.dart';

class VisitorListScreen extends StatelessWidget {
  const VisitorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final visitors = [
      VisitorModel(
        id: 'v1',
        name: 'Rahul Verma',
        phone: '9876543210',
        purpose: 'Delivery',
        status: VisitorStatus.approved,
        hostId: 'h1',
        hostName: 'Sunil Kumar',
        apartmentId: 'a1',
        apartmentNo: 'A-101',
        checkInTime: DateTime.now().subtract(const Duration(minutes: 45)),
        createdBy: 'guard1',
      ),
      VisitorModel(
        id: 'v2',
        name: 'Suresh Patil',
        phone: '9123456789',
        purpose: 'Maintenance',
        status: VisitorStatus.pending,
        hostId: 'h2',
        hostName: 'Anita Verma',
        apartmentId: 'a2',
        apartmentNo: 'A-102',
        checkInTime: DateTime.now().subtract(const Duration(minutes: 10)),
        createdBy: 'guard1',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('All Visitors Log')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        itemCount: visitors.length,
        itemBuilder: (context, index) {
          return VisitorCard(visitor: visitors[index]);
        },
      ),
    );
  }
}
