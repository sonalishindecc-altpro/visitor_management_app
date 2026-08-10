import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class AddVisitorScreen extends StatefulWidget {
  const AddVisitorScreen({super.key});

  @override
  State<AddVisitorScreen> createState() => _AddVisitorScreenState();
}

class _AddVisitorScreenState extends State<AddVisitorScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _aptController = TextEditingController();
  final _purposeController = TextEditingController();
  final _vehicleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Visitor')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accent, width: 1.5),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined, color: AppColors.accent, size: 36),
                    SizedBox(height: 4),
                    Text('Take Photo', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(label: 'Visitor Full Name', controller: _nameController, prefixIcon: Icons.person_outline),
            const SizedBox(height: 16),
            AppTextField(label: 'Phone Number', controller: _phoneController, prefixIcon: Icons.phone_outlined, keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            AppTextField(label: 'Apartment Number (e.g. A-102)', controller: _aptController, prefixIcon: Icons.home_outlined),
            const SizedBox(height: 16),
            AppTextField(label: 'Purpose of Visit', controller: _purposeController, prefixIcon: Icons.work_outline),
            const SizedBox(height: 16),
            AppTextField(label: 'Vehicle Number (Optional)', controller: _vehicleController, prefixIcon: Icons.directions_car_outlined),
            const SizedBox(height: 24),
            AppButton(
              label: 'REGISTER & NOTIFY RESIDENT',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Visitor registered & notification sent to resident!')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
