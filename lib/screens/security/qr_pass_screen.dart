import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/constants/app_constants.dart';

class QrPassScreen extends StatelessWidget {
  final String? qrData;
  const QrPassScreen({super.key, this.qrData});

  @override
  Widget build(BuildContext context) {
    final data = qrData ?? 'SECUREGATE:VISITOR:100923';

    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Gate Pass')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('GUEST ENTRY PASS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.accent)),
                  const SizedBox(height: 16),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    child: QrImageView(
                      data: data,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Show this QR code at society security gate.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
