import 'package:flutter/material.dart';
import '../utils/background_scanner.dart';

class AlertsScreen extends StatefulWidget {
  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  List<Map<String, dynamic>> _alerts = [];

  @override
  void initState() {
    super.initState();
    _alerts = BackgroundScanner.history;

    // Periodically refresh to simulate live updates
    BackgroundScanner.onNewThreat = () {
      setState(() {
        _alerts = BackgroundScanner.history;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return _alerts.isEmpty
        ? Center(
      child: Text(
        'No alerts yet!',
        style: TextStyle(fontSize: 20),
      ),
    )
        : ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: _alerts.length,
      itemBuilder: (context, index) {
        final alert = _alerts[index];
        return Card(
          color: Color(0xFFFFF3F3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.warning, color: Colors.red, size: 32),
            title: Text(
              alert['content'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                "Time: ${alert['timestamp']}\nRisk Score: ${alert['riskScore']}"),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
