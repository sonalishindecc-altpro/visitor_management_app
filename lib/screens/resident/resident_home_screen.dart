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
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: const Text('My Home (Flat A-102)'),
        backgroundColor: AppColors.primary,
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
            const Text(
              'Resident Dashboard',
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
              icon: Icons.add_moderator,
              title: 'Pre-register a Guest',
              onTap: () => Navigator.pushNamed(context, AppRoutes.preRegister),
            ),
            _buildActionTile(
              context,
              icon: Icons.history,
              title: 'My Visitor History',
              onTap: () => Navigator.pushNamed(context, AppRoutes.visitorHistory),
            ),
            _buildActionTile(
              context,
              icon: Icons.help_outline,
              title: 'Contact Society Office',
              onTap: () {},
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
        icon: const Icon(Icons.add),
        label: const Text('NEW PASS', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.preRegister),
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
