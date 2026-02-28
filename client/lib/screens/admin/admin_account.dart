import 'package:client/screens/register.dart';
import 'package:client/util/user_storage.dart';
import 'package:flutter/material.dart';

class AdminAccount extends StatefulWidget {
  const AdminAccount({super.key});

  @override
  State<AdminAccount> createState() => _AdminAccountState();
}

class _AdminAccountState extends State<AdminAccount> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void _logout() {
    UserStorage.clear();
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Register()));
  }

  Map<String, dynamic>? user;
  Future<void> loadUser() async {
    final userData = await UserStorage.getUser();
    setState(() {
      user = userData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Account'), centerTitle: true),
      body: isLoading
          ? Center(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Column(
                    children: [
                      Text(
                        user?['name'] ?? 'Unknown User',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email - ${user?['email']}',
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
