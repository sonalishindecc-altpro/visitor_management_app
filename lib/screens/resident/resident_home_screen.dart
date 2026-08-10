import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../models/visitor_model.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/visitor_card.dart';

class ResidentHomeScreen extends StatelessWidget {
  const ResidentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pendingVisitor = VisitorModel(
      id: 'v10',
      name: 'Amol Shinde',
      phone: '9822012345',
      purpose: 'Delivery (Amazon)',
      status: VisitorStatus.pending,
      hostId: 'r1',
      hostName: 'Current User',
      apartmentId: 'a1',
      apartmentNo: 'A-102',
      checkInTime: DateTime.now(),
      createdBy: 'guard1',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home (Flat A-102)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DashboardCard(
                    title: 'Visitor Requests',
                    value: '1 Pending',
                    icon: Icons.notifications_active_outlined,
                    color: AppColors.warning,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.visitorRequests),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DashboardCard(
                    title: 'Pre-registered',
                    value: '2 Passes',
                    icon: Icons.qr_code,
                    color: AppColors.accent,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.visitorHistory),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Pending Gate Approval',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            VisitorCard(
              visitor: pendingVisitor,
              showActions: true,
              onApprove: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Visitor Approved! Gate notified.')),
                );
              },
              onDeny: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Visitor Denied.')),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add_moderator),
        label: const Text('PRE-REGISTER GUEST', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.preRegister),
      ),
    );
  }
}
