import 'package:client/screens/admin/tabs.dart';
import 'package:client/screens/hosteller/home.dart';
import 'package:client/screens/register.dart';
import 'package:client/util/user_storage.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  Map<String, dynamic>? user;
  Future<void> fetchUser() async {
    user = await UserStorage.getUser();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Register();
    } else if (user?['role'] == 'admin') {
      return Tabs();
    } else {
      return Home();
    }
  }
}
