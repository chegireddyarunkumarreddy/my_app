import 'package:flutter/material.dart';
import 'package:my_app/screens/dashboard_screen.dart';
import 'package:my_app/screens/scanner_screen.dart';
import 'package:my_app/screens/reports_screen.dart';
import 'package:my_app/utils/background_scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local notifications
  await initNotifications();

  // Start background threat scanning
  BackgroundScanner.start();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CyberShield',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomeScreen(),
      routes: {
        '/reports': (context) => ReportsScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      DashboardScreen(
        onScanPressed: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
      ScannerScreen(),
      ReportsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('CyberShield'),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: 'Reports'),
        ],
      ),
    );
  }
}
