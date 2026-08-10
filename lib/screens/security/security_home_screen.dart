import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../models/visitor_model.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/visitor_card.dart';

class SecurityHomeScreen extends StatelessWidget {
  const SecurityHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockVisitor = VisitorModel(
      id: 'v1',
      name: 'Ramesh Sharma',
      phone: '9876543210',
      purpose: 'Delivery',
      status: VisitorStatus.pending,
      hostId: 'h1',
      hostName: 'Anita Verma',
      apartmentId: 'a1',
      apartmentNo: 'A-102',
      checkInTime: DateTime.now(),
      createdBy: 'guard1',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Portal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.qrScanner),
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
                    title: "Today's Check-ins",
                    value: '18',
                    icon: Icons.login_rounded,
                    color: AppColors.success,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.visitorList),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DashboardCard(
                    title: 'Pending Approvals',
                    value: '3',
                    icon: Icons.pending_actions,
                    color: AppColors.warning,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.visitorList),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Entry Logs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.visitorList),
                  child: const Text('View All', style: TextStyle(color: AppColors.accent)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            VisitorCard(
              visitor: mockVisitor,
              showActions: true,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.visitorDetails,
                arguments: mockVisitor,
              ),
              onApprove: () {},
              onDeny: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('ADD VISITOR', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addVisitor),
      ),
    );
  }
}
