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
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => Register()),
      (route) => false,
    );
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
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Avatar
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),

                        SizedBox(width: 16),

                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?['name'] ?? 'Unknown User',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),

                              SizedBox(height: 6),

                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      user?['email'] ?? 'No email',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
