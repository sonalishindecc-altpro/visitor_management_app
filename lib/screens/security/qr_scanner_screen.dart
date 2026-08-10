import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Pass')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(color: Colors.black),
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.accent, width: 3),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Positioned(
            bottom: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
              icon: const Icon(Icons.flash_on, color: Colors.black),
              label: const Text('SIMULATE SCAN SUCCESS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('QR Pass Validated! Visitor Allowed.')),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
