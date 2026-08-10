import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class PreRegisterScreen extends StatefulWidget {
  const PreRegisterScreen({super.key});

  @override
  State<PreRegisterScreen> createState() => _PreRegisterScreenState();
}

class _PreRegisterScreenState extends State<PreRegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _purposeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pre-Register Guest')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          children: [
            const Icon(Icons.qr_code_2_rounded, size: 72, color: AppColors.accent),
            const SizedBox(height: 12),
            const Text('Generate Gate Pass QR Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 24),
            AppTextField(label: 'Guest Name', controller: _nameController, prefixIcon: Icons.person_outline),
            const SizedBox(height: 16),
            AppTextField(label: 'Guest Phone', controller: _phoneController, prefixIcon: Icons.phone_outlined),
            const SizedBox(height: 16),
            AppTextField(label: 'Visit Purpose', controller: _purposeController, prefixIcon: Icons.card_travel_outlined),
            const SizedBox(height: 24),
            AppButton(
              label: 'GENERATE & SHARE QR PASS',
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.qrPass);
              },
            ),
          ],
        ),
      ),
    );
  }
}
