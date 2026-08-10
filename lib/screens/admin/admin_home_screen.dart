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
              childAspectRatio: 1.2,
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
            ListTile(
              leading: const Icon(Icons.group_outlined, color: AppColors.accent),
              title: const Text('Manage Users & Guards'),
              trailing: const Icon(Icons.chevron_right, color: Colors.white54),
              onTap: () => Navigator.pushNamed(context, AppRoutes.users),
            ),
            ListTile(
              leading: const Icon(Icons.apartment, color: AppColors.accent),
              title: const Text('Manage Apartments'),
              trailing: const Icon(Icons.chevron_right, color: Colors.white54),
              onTap: () => Navigator.pushNamed(context, AppRoutes.apartments),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart, color: AppColors.accent),
              title: const Text('Analytics & PDF Reports'),
              trailing: const Icon(Icons.chevron_right, color: Colors.white54),
              onTap: () => Navigator.pushNamed(context, AppRoutes.reports),
            ),
            ListTile(
              leading: const Icon(Icons.history, color: AppColors.accent),
              title: const Text('Activity Audit Logs'),
              trailing: const Icon(Icons.chevron_right, color: Colors.white54),
              onTap: () => Navigator.pushNamed(context, AppRoutes.activityLogs),
            ),
          ],
        ),
      ),
    );
  }
}
