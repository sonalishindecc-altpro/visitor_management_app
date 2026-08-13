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
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: const Text('Security Portal'),
        backgroundColor: AppColors.primary,
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
            const Text(
              'Security Overview',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
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
            const Text(
              'Quick Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildActionTile(
              context,
              icon: Icons.person_add_alt_1,
              title: 'Register New Visitor',
              onTap: () => Navigator.pushNamed(context, AppRoutes.addVisitor),
            ),
            _buildActionTile(
              context,
              icon: Icons.qr_code_scanner,
              title: 'Scan QR Pass',
              onTap: () => Navigator.pushNamed(context, AppRoutes.qrScanner),
            ),
            _buildActionTile(
              context,
              icon: Icons.list_alt,
              title: 'View All Logs',
              onTap: () => Navigator.pushNamed(context, AppRoutes.visitorList),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Entry Log',
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
        icon: const Icon(Icons.add),
        label: const Text('ADD VISITOR', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addVisitor),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.accent),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white54, size: 20),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
      ),
    );
  }
}
