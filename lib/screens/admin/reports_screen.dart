import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/app_button.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports & Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.pie_chart, size: 64, color: AppColors.accent),
                    SizedBox(height: 12),
                    Text('Monthly Visitor Stats', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Total Visitors: 1,240 | Approved: 1,180'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            AppButton(
              label: 'EXPORT PDF REPORT',
              icon: Icons.picture_as_pdf,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generating PDF Report...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
