import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../models/visitor_model.dart';
import '../../widgets/visitor_card.dart';

class VisitorRequestsScreen extends StatelessWidget {
  const VisitorRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pending = VisitorModel(
      id: 'v10',
      name: 'Amol Shinde',
      phone: '9822012345',
      purpose: 'Delivery',
      status: VisitorStatus.pending,
      hostId: 'r1',
      hostName: 'Current User',
      apartmentId: 'a1',
      apartmentNo: 'A-102',
      checkInTime: DateTime.now(),
      createdBy: 'guard1',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Approval Requests')),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: [
          VisitorCard(
            visitor: pending,
            showActions: true,
            onApprove: () {},
            onDeny: () {},
          ),
        ],
      ),
    );
  }
}
