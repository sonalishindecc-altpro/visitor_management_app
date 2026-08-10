import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ExpansionTile(
            title: Text('How do I approve a visitor?'),
            children: [Padding(padding: EdgeInsets.all(12), child: Text('Open the app notification or Resident Home screen and tap "Approve".'))],
          ),
          ExpansionTile(
            title: Text('How do pre-registered QR passes work?'),
            children: [Padding(padding: EdgeInsets.all(12), child: Text('Tap "Pre-Register Guest", fill details, and share the generated QR code image.'))],
          ),
        ],
      ),
    );
  }
}
