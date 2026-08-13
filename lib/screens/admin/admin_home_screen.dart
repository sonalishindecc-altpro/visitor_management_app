import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/dashboard_card.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
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
              'System Summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
<<<<<<< Updated upstream
              childAspectRatio: 1.1, // Adjusted for better height
=======
              childAspectRatio:  0.85,
>>>>>>> Stashed changes
              children: [
                DashboardCard(
                  title: 'Total Visitors Today',
                  value: '42',
                  icon: Icons.people_outline,
                  color: AppColors.accent,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.visitorList),
                ),
                DashboardCard(
                  title: 'Active Guards',
                  value: '8',
                  icon: Icons.shield_outlined,
                  color: AppColors.info,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.users),
                ),
                DashboardCard(
                  title: 'Apartment Units',
                  value: '120',
                  icon: Icons.apartment_outlined,
                  color: AppColors.success,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.apartments),
                ),
                DashboardCard(
                  title: 'Pending Requests',
                  value: '5',
                  icon: Icons.hourglass_top_outlined,
                  color: AppColors.warning,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.visitorList),
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
              icon: Icons.group_outlined,
              title: 'Manage Users & Guards',
              onTap: () => Navigator.pushNamed(context, AppRoutes.users),
            ),
            _buildActionTile(
              icon: Icons.apartment,
              title: 'Manage Apartments',
              onTap: () => Navigator.pushNamed(context, AppRoutes.apartments),
            ),
            _buildActionTile(
              icon: Icons.bar_chart,
              title: 'Analytics & PDF Reports',
              onTap: () => Navigator.pushNamed(context, AppRoutes.reports),
            ),
            _buildActionTile(
              icon: Icons.history,
              title: 'Activity Audit Logs',
              onTap: () => Navigator.pushNamed(context, AppRoutes.activityLogs),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
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
