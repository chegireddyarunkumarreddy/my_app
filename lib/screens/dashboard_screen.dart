import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onScanPressed;

  const DashboardScreen({Key? key, required this.onScanPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/dashboard.png',
            width: 320,
            height: 320,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          Text(
            "Welcome to CyberShield!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Protect your device with real-time threat detection,\nscan logs, and smart recommendations.",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: onScanPressed, // ✅ uses the passed callback to switch tab
            icon: Icon(Icons.play_arrow),
            label: Text(
              "Run Full Scan",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
