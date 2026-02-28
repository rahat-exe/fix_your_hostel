import 'package:client/screens/admin/admin_account.dart';
import 'package:client/screens/admin/admin_complaints.dart';
import 'package:client/screens/admin/admin_home.dart';
import 'package:client/screens/admin/admin_insights.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      AdminHome(),
      AdminComplaint(),
      AdminInsights(),
      AdminAccount(),
    ];
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Builder(
        builder: (context) {
          // use theme values so the bar responds to light/dark mode
          final navTheme = Theme.of(context).bottomNavigationBarTheme;
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: navTheme.backgroundColor ?? Colors.black,
            unselectedItemColor: navTheme.unselectedItemColor,
            selectedItemColor: navTheme.selectedItemColor,
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Complaints',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.insights_sharp),
                label: 'Insights',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: 'Account',
              ),
            ],
          );
        },
      ),
    );
  }
}
