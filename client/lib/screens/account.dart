import 'package:client/util/user_storage.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Map<String, dynamic>? user;
  Future<void> loadUser() async {
    final userData = await UserStorage.getUser();
    setState(() {
      user = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Account'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Column(
              children: [
                Text(
                  user?['name'] ?? 'Unknown User',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Email - ${user?['email']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.withValues(alpha: 0.9),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Hostel Address - Hostel B, NB-80',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            const Divider(),
            ListTile(
              leading: Icon(Icons.person_2_outlined),
              title: Text('Edit Private Details'),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ),
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Change Password'),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text('Logout'),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ),
            const Divider(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
