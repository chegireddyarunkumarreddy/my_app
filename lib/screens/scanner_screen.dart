import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/utils/background_scanner.dart';
import 'package:my_app/screens/reports_screen.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  List<String> alerts = [];

  @override
  void initState() {
    super.initState();
    BackgroundScanner.setAlertListener(_handleNewAlert);
  }

  void _handleNewAlert(Map<String, dynamic> alert) {
    final message = "🛡️ Blocked ${alert['content']}";
    setState(() {
      alerts.insert(0, "${alert['timestamp']} - $message");
    });
  }

  @override
  void dispose() {
    BackgroundScanner.removeAlertListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scanner")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Lottie.asset('assets/animations/scan.json', width: 200),
          SizedBox(height: 10),
          Text(
            "Background scanning & threat blocking active",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportsScreen()),
              );
            },
            icon: Icon(Icons.description),
            label: Text("View Reports", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.shield, color: Colors.deepPurple),
                title: Text(alerts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
