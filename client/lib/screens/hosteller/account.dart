import 'package:client/screens/register.dart';
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

  void _logout() {
    UserStorage.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => Register()),
      (route) => false,
    );
  }

  Map<String, dynamic>? user;
  Future<void> loadUser() async {
    final userData = await UserStorage.getUser();
    print(userData);
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
            Container(
              padding: EdgeInsets.all(18),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👤 Name
                  Text(
                    user?['name'] ?? 'Unknown User',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),

                  SizedBox(height: 14),

                  // 📧 Email
                  Row(
                    children: [
                      Icon(Icons.email_outlined, size: 18, color: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          user?['email'] ?? 'No email',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // 🏠 Hostel Address
                  Row(
                    children: [
                      Icon(Icons.home_outlined, size: 18, color: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${user?['hostelBlock'] ?? '-'}, Room ${user?['roomNumber'] ?? '-'}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
              onTap: _logout,
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
