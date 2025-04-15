import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; //  Add this line

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan in Progress'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/scan.json',
            width: 250,
            height: 250,
            repeat: true,
          ),
          SizedBox(height: 20),
          Text(
            "Scanning for threats...",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/reports');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text("View Report", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
