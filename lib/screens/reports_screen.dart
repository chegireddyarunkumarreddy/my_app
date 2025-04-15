import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:my_app/utils/background_scanner.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Map<String, dynamic>> scanHistory = [];

  @override
  void initState() {
    super.initState();
    scanHistory = List.from(BackgroundScanner.history.reversed);
  }

  void generateReport(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('CyberShield Scan Report',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            for (var scan in scanHistory)
              pw.Container(
                margin: pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('📅 ${scan["timestamp"]}', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Text('⚠️ Threat: ${scan["content"]}', style: pw.TextStyle(fontSize: 12)),
                    pw.Text('🔍 Risk Score: ${scan["riskScore"]}', style: pw.TextStyle(fontSize: 12)),
                    pw.SizedBox(height: 5),
                  ],
                ),
              )
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final bool hasAppBar = ModalRoute.of(context)?.canPop ?? false;

    return hasAppBar
        ? Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        leading: BackButton(),
      ),
      body: _buildReportContent(context),
    )
        : _buildReportContent(context);
  }

  Widget _buildReportContent(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Image.asset(
            'assets/images/report.png',
            width: 250,
            height: 250,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton.icon(
            onPressed: () => generateReport(context),
            icon: Icon(Icons.download),
            label: Text("Download Report", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: scanHistory.length,
            itemBuilder: (context, index) {
              var scan = scanHistory[index];
              return Card(
                color: Color(0xFFF6F0FB),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ExpansionTile(
                  leading: Icon(Icons.security, color: Colors.deepPurple, size: 32),
                  title: Text("Scan on ${scan['timestamp']}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(scan['content']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Threat: ${scan['content']}", style: TextStyle(fontSize: 14)),
                          SizedBox(height: 4),
                          Text("Risk Score: ${scan['riskScore']}", style: TextStyle(fontSize: 14)),
                          SizedBox(height: 4),
                          Text("Status: Blocked Automatically", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
