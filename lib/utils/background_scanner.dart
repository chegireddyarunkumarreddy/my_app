import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const settings = InitializationSettings(android: android);
  await notificationsPlugin.initialize(settings);
}

Future<void> showThreatNotification(String content) async {
  const androidDetails = AndroidNotificationDetails(
    'scan_channel',
    'Scan Alerts',
    importance: Importance.high,
    priority: Priority.high,
  );
  const platformDetails = NotificationDetails(android: androidDetails);

  if (Platform.isAndroid || Platform.isIOS) {
    await notificationsPlugin.show(0, 'Threat Blocked', content, platformDetails);
  } else {
    print("🔒 Threat Blocked: $content");
  }
}

class BackgroundScanner {
  static Timer? _timer;
  static final List<Map<String, dynamic>> scanHistory = [];
  static Function(Map<String, dynamic>)? _onNewAlert;

  static void start() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      _simulateThreat();
    });
  }

  static void runManualScan() {
    for (int i = 0; i < 3; i++) {
      _simulateThreat();
    }
  }

  static void _simulateThreat() {
    final threats = [
      'Suspicious link: http://phishingsite.com',
      'Malware App: SpyTracker',
      'Dangerous File: virus_payload.exe',
      'Infected App: FakeBrowser',
      'Unsafe Script: steal_data.js',
    ];
    final random = Random();
    final content = threats[random.nextInt(threats.length)];
    final timestamp = DateTime.now().toString().split('.')[0];
    final riskScore = random.nextInt(40) + 60;

    final alert = {
      'content': content,
      'timestamp': timestamp,
      'riskScore': riskScore,
    };

    scanHistory.add(alert);
    _onNewAlert?.call(alert);
    showThreatNotification(content);
  }

  static List<Map<String, dynamic>> get history => scanHistory;

  static void setAlertListener(Function(Map<String, dynamic>) callback) {
    _onNewAlert = callback;
  }

  static void removeAlertListener() {
    _onNewAlert = null;
  }
}
