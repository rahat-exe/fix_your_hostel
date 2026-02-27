import 'package:client/screens/hosteller/account.dart';
import 'package:client/screens/hosteller/home.dart';
import 'package:client/screens/hosteller/my_issues.dart';
import 'package:flutter/material.dart';

class HostellerTabs extends StatefulWidget {
  const HostellerTabs({super.key});

  @override
  State<HostellerTabs> createState() => _HostellerTabsState();
}

class _HostellerTabsState extends State<HostellerTabs> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [Home(), MyIssues(), AccountScreen()];
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
                label: 'My Issues ',
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
